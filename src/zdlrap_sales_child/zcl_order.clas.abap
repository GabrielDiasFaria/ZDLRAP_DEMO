CLASS zcl_order DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_order IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Inserir Status
    TYPES tt_products TYPE TABLE OF zdlrap_products WITH DEFAULT KEY.
    DATA(lt_products) = VALUE tt_products(
        ( productid = 1
          description = 'Notebook Acer'
          value = 1000
          currency = 'BRL'
          quantity = 1
          unity_measure = 'UN' )
        ( productid = 2
          description = 'MacBook Pro M2'
          value = 10000
          currency = 'BRL'
          quantity = 1
          unity_measure = 'UN' )
    ).
    MODIFY zdlrap_products FROM TABLE lt_products.

    TYPES tt_order TYPE TABLE OF zdlrap_order WITH DEFAULT KEY.
    DATA(lt_order) = VALUE tt_order(
        ( orderid = 1 customer = 1 vendor = 2 company = 3 )
    ).
    MODIFY zdlrap_order FROM TABLE lt_order.

    TYPES tt_order_it TYPE TABLE OF zdlrap_order_it WITH DEFAULT KEY.
    DATA(lt_order_it) = VALUE tt_order_it(
        ( orderid = 1 item = 1 product = 1 quantity = 2 unity_measure = 'UN' )
    ).
    MODIFY zdlrap_order_it FROM TABLE lt_order_it.
  ENDMETHOD.

ENDCLASS.
