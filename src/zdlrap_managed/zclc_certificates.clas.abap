CLASS zclc_certificates DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclc_certificates IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TYPES: tt_certf TYPE TABLE OF zdlrap_certif WITH DEFAULT KEY.

    DELETE FROM zdlrap_certif.

    DATA(lt_certf) = VALUE tt_certf(
        ( cert_uuid = '1' matnr = '1' )
        ( cert_uuid = '2' matnr = '2' )
        ( cert_uuid = '3' matnr = '3' )
    ).

    MODIFY zdlrap_certif FROM TABLE @lt_certf.

    out->write( 'Produtos Inseridos com sucesso!' ).
  ENDMETHOD.

ENDCLASS.
