CLASS lhc_Certificate DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    " Status 01 - Novo
    " Status 02 - Inativo
    " Status 03 - Ativo

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Certificate RESULT result.

    METHODS setinitialvalues FOR DETERMINE ON MODIFY
      IMPORTING keys FOR certificate~setinitialvalues.

    METHODS checkmaterial FOR VALIDATE ON SAVE
      IMPORTING keys FOR certificate~checkmaterial.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR certificate RESULT result.

    METHODS activeversion FOR MODIFY
      IMPORTING keys FOR ACTION certificate~activeversion RESULT result.

    METHODS inactiveversion FOR MODIFY
      IMPORTING keys FOR ACTION certificate~inactiveversion RESULT result.

    METHODS newversion FOR MODIFY
      IMPORTING keys FOR ACTION certificate~newversion RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR certificate RESULT result.

ENDCLASS.

CLASS lhc_Certificate IMPLEMENTATION.

  METHOD get_instance_authorizations.

    READ ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        FIELDS ( Version )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_certificates).

    CHECK lt_certificates IS NOT INITIAL.

    LOOP AT lt_certificates INTO DATA(ls_certificates).

        APPEND VALUE #( LET upd_auth = COND #( WHEN ls_certificates-Version = 2
                                                then if_abap_behv=>auth-unauthorized
                                               ELSE if_abap_behv=>auth-allowed )
                            del_auth = if_abap_behv=>auth-unauthorized
                        IN
                         %tky                   = ls_certificates-%tky
                         %update                = upd_auth
                         %action-Edit           = upd_auth
                         %action-NewVersion     = upd_auth
                         %delete                = del_auth
                      ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_global_authorizations.

    " Se o usuário estiver tentando criar...
*    IF requested_authorizations-%action-NewVersion = if_abap_behv=>mk-on.
*        " Authority Check
*        result-%action-NewVersion = if_abap_behv=>auth-unauthorized.
*    ENDIF.

  ENDMETHOD.

  METHOD setInitialValues.

    READ ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        FIELDS ( CertStatus )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_certificates).

    " Adicionar Novos Valores Certificado!
    IF lt_certificates IS NOT INITIAL.
      MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
          ENTITY Certificate
          UPDATE
          FIELDS ( Version CertStatus )
          WITH VALUE #( FOR ls_certificate IN lt_certificates
                        ( %tky = ls_certificate-%tky
                          Version = 1
                          CertStatus = 1 ) ).
    ENDIF.

    DATA: lt_state       TYPE TABLE FOR CREATE zi_dlrap_certifproduct\_Stats,
          ls_state       LIKE LINE OF lt_state,
          ls_state_value LIKE LINE OF ls_state-%target.

    LOOP AT lt_certificates INTO DATA(ls_certificates).

      ls_state-%key = ls_certificates-%key.
      ls_state-CertUuid = ls_state_value-CertUuid = ls_certificates-CertUuid.

      ls_state_value-Version   = 1.
      ls_state_value-StatusOld = space.
      ls_state_value-Status    = 1.
      ls_state_value-%cid      = ls_state-CertUuid.

      ls_state_value-%control-Version         = if_abap_behv=>mk-on.
      ls_state_value-%control-StatusOld       = if_abap_behv=>mk-on.
      ls_state_value-%control-Status          = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedAt   = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedBy   = if_abap_behv=>mk-on.
      APPEND ls_state_value TO ls_state-%target.

      APPEND ls_state TO lt_state.

      MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        CREATE BY \_Stats
        FROM lt_state
          REPORTED DATA(ls_return_ass)
          MAPPED DATA(ls_mapped_ass)
          FAILED DATA(ls_failed_ass).

    ENDLOOP.

  ENDMETHOD.

  METHOD checkMaterial.

    READ ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        FIELDS ( CertStatus )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_certificates).

    CHECK lt_certificates IS NOT INITIAL.

    SELECT *
        FROM zdlrap_product
        INTO TABLE @DATA(lt_material).

    LOOP AT lt_certificates INTO DATA(ls_certificates).
      IF ls_certificates-Matnr IS INITIAL OR
         NOT line_exists( lt_material[ matnr = ls_certificates-Matnr ] ).

*           APPEND VALUE #( %tky = ls_certificates-%tky ) TO failed-certificate.
        APPEND VALUE #(  %tky        = ls_certificates-%tky
                         %state_area = 'MATERIAL_UNKNOWN'
                         %msg        = NEW zcx_dlrap_certificate(
                                         severity = if_abap_behv_message=>severity-error
                                         textid = zcx_dlrap_certificate=>material_unknown
                                         attr1 = CONV string( ls_certificates-Matnr ) )
                         )
                         TO reported-certificate.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD ActiveVersion.

    READ ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY certificate
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_certificates).

    " Filhos
    DATA: lt_state       TYPE TABLE FOR CREATE zi_dlrap_certifproduct\_Stats,
          ls_state       LIKE LINE OF lt_state,
          ls_state_value LIKE LINE OF ls_state-%target.

    LOOP AT lt_certificates INTO DATA(ls_certificates).

      ls_state-%key = ls_certificates-%key.
      ls_state-CertUuid = ls_state_value-CertUuid = ls_certificates-CertUuid.

      ls_state_value-Version   = ls_certificates-Version.
      ls_state_value-StatusOld = ls_certificates-CertStatus.
      ls_state_value-Status    = 3.

      ls_state_value-%control-Version         = if_abap_behv=>mk-on.
      ls_state_value-%control-StatusOld       = if_abap_behv=>mk-on.
      ls_state_value-%control-Status          = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedAt   = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedBy   = if_abap_behv=>mk-on.
      APPEND ls_state_value TO ls_state-%target.

      APPEND ls_state TO lt_state.

      MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        CREATE BY \_Stats
        FROM lt_state
          REPORTED DATA(ls_return_ass)
          MAPPED DATA(ls_mapped_ass)
          FAILED DATA(ls_failed_ass).

    ENDLOOP.

    MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        UPDATE
        FIELDS ( Version CertStatus Matnr )
        WITH VALUE #( FOR key IN lt_certificates
                      ( %tky = key-%tky
                        Version = key-Version
                        Matnr   = key-Matnr
                        CertStatus = 3 ) )
            FAILED failed
            REPORTED reported.

    reported-certificate = VALUE #( FOR ls_report IN lt_certificates
                      ( %tky   = ls_report-%tky
                        %msg   = new_message( id       = 'ZDLRAP_MANAGED'
                                              number   = '002'
                                              severity = if_abap_behv_message=>severity-success ) ) ).

    result = VALUE #( FOR certificate IN lt_certificates
                      ( %tky   = certificate-%tky
                        %param = certificate ) ).


  ENDMETHOD.

  METHOD InactiveVersion.

    READ ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY certificate
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_certificates).

    " Filhos
    DATA: lt_state       TYPE TABLE FOR CREATE zi_dlrap_certifproduct\_Stats,
          ls_state       LIKE LINE OF lt_state,
          ls_state_value LIKE LINE OF ls_state-%target.

    LOOP AT lt_certificates INTO DATA(ls_certificates).

      ls_state-%key = ls_certificates-%key.
      ls_state-CertUuid = ls_state_value-CertUuid = ls_certificates-CertUuid.

      ls_state_value-Version   = ls_certificates-Version.
      ls_state_value-StatusOld = ls_certificates-CertStatus.
      ls_state_value-Status    = 2.

      ls_state_value-%control-Version         = if_abap_behv=>mk-on.
      ls_state_value-%control-StatusOld       = if_abap_behv=>mk-on.
      ls_state_value-%control-Status          = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedAt   = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedBy   = if_abap_behv=>mk-on.
      APPEND ls_state_value TO ls_state-%target.

      APPEND ls_state TO lt_state.

      MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        CREATE BY \_Stats
        FROM lt_state
          REPORTED DATA(ls_return_ass)
          MAPPED DATA(ls_mapped_ass)
          FAILED DATA(ls_failed_ass).

    ENDLOOP.

    MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        UPDATE
        FIELDS ( Version CertStatus Matnr )
        WITH VALUE #( FOR key IN lt_certificates
                      ( %tky = key-%tky
                        Version = key-Version
                        Matnr   = key-Matnr
                        CertStatus = 2 ) )
            FAILED failed
            REPORTED reported.

    reported-certificate = VALUE #( FOR ls_report IN lt_certificates
                      ( %tky   = ls_report-%tky
                        %msg   = new_message( id       = 'ZDLRAP_MANAGED'
                                              number   = '002'
                                              severity = if_abap_behv_message=>severity-success ) ) ).

    result = VALUE #( FOR certificate IN lt_certificates
                      ( %tky   = certificate-%tky
                        %param = certificate ) ).

  ENDMETHOD.

  METHOD NewVersion.

    " Selecionar os dados selecionados da grid do App para o action
    READ ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY certificate
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_certificates).

    " Adicionar um novo log de status
    DATA: lt_state       TYPE TABLE FOR CREATE zi_dlrap_certifproduct\_Stats,
          ls_state       LIKE LINE OF lt_state,
          ls_state_value LIKE LINE OF ls_state-%target.

    LOOP AT lt_certificates INTO DATA(ls_certificates).

      ls_state-%key = ls_certificates-%key.
      ls_state-CertUuid = ls_state_value-CertUuid = ls_certificates-CertUuid.

      ls_state_value-Version   = ls_certificates-Version + 1.
      ls_state_value-StatusOld = ls_certificates-CertStatus.
      ls_state_value-Status    = 1. " Novo

      ls_state_value-%control-Version         = if_abap_behv=>mk-on.
      ls_state_value-%control-StatusOld       = if_abap_behv=>mk-on.
      ls_state_value-%control-Status          = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedAt   = if_abap_behv=>mk-on.
      ls_state_value-%control-LastChangedBy   = if_abap_behv=>mk-on.
      APPEND ls_state_value TO ls_state-%target.

      APPEND ls_state TO lt_state.

      MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        CREATE BY \_Stats
        FROM lt_state
          REPORTED DATA(ls_return_ass)
          MAPPED DATA(ls_mapped_ass)
          FAILED DATA(ls_failed_ass).

    ENDLOOP.

    " Modificar para uma nova versão o pai
    MODIFY ENTITIES OF zi_dlrap_certifproduct IN LOCAL MODE
        ENTITY Certificate
        UPDATE
        FIELDS ( Version CertStatus Matnr )
        WITH VALUE #( FOR ls_modify IN lt_certificates
                      ( %tky = ls_modify-%tky
                        Version = ls_modify-Version + 1
                        Matnr   = ls_modify-Matnr
                        CertStatus = 1 ) )
            FAILED failed
            REPORTED reported.

    " mensagem de sucesso
    reported-certificate = VALUE #(
        FOR ls_report IN lt_certificates
        ( %tky   = ls_report-%tky
          %msg   = new_message( id       = 'ZDLRAP_MANAGED'
                                number   = '002'
                                severity = if_abap_behv_message=>severity-success ) ) ).

    " retorno para um refresh do frontend
    result = VALUE #( FOR certificate IN lt_certificates
                      ( %tky   = certificate-%tky
                        %param = certificate ) ).


  ENDMETHOD.

ENDCLASS.
