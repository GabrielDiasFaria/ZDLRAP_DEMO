CLASS zclc_products DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclc_products IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES: tt_products TYPE TABLE OF zdlrap_product WITH DEFAULT KEY.

    DELETE FROM zdlrap_product.

    DATA(lt_products) = VALUE tt_products(
        ( matnr = '1' description = 'Celular'       language = 'P' )
        ( matnr = '2' description = 'Televisao'     language = 'P' )
        ( matnr = '3' description = 'Computador'    language = 'P' )
        ( matnr = '1' description = 'Phone'         language = 'E' )
        ( matnr = '2' description = 'Television'    language = 'E' )
        ( matnr = '3' description = 'Computer'      language = 'E' )
    ).

    MODIFY zdlrap_product FROM TABLE @lt_products.

    out->write( 'Produtos Inseridos com sucesso!' ).
  ENDMETHOD.

ENDCLASS.
