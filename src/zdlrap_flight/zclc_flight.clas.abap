CLASS zclc_flight DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclc_flight IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " Inserir Status
    TYPES tt_stat TYPE TABLE OF zdl_flight_stat WITH DEFAULT KEY.
    DATA(lt_status) = VALUE tt_stat(
        ( id = '1' description = 'Aguardando Aprovação' )
        ( id = '2' description = 'Aprovado' )
        ( id = '3' description = 'Reprovado' )
    ).
    MODIFY zdl_flight_stat FROM TABLE lt_status.

    " Inserir Cidades
    TYPES tt_city TYPE TABLE OF zdl_flight_city WITH DEFAULT KEY.
    DATA(lt_city) = VALUE tt_city(
        ( id = '1' description = 'São Paulo' )
        ( id = '2' description = 'Lisboa' )
        ( id = '3' description = 'Rio de Janeiro' )
        ( id = '4' description = 'Fortaleza' )
    ).
    MODIFY zdl_flight_city FROM TABLE lt_city.

    " Inserir Voos
    TYPES tt_flight TYPE TABLE OF zdl_flight WITH DEFAULT KEY.
    DATA(lt_flight) = VALUE tt_flight(
        (   id = '1'
            departure_date  = '20240101'
            arrival_date    = '20240102'
            city_from       = 1
            city_to         = 2
            price           = 5250
            waers           = 'BRL'
            status          = 1 )
        (   id = '2'
            departure_date  = '20240201'
            arrival_date    = '20240201'
            city_from       = 1
            city_to         = 3
            price           = 532
            waers           = 'BRL'
            status          = 2 )
        (   id = '3'
            departure_date  = '20240211'
            arrival_date    = '20240212'
            city_from       = 2
            city_to         = 3
            price           = 1100
            waers           = 'EUR'
            status          = 3 )
    ).
    MODIFY zdl_flight FROM TABLE lt_flight.

    out->write( 'Dados Inseridos com sucesso!' ).

  ENDMETHOD.

ENDCLASS.
