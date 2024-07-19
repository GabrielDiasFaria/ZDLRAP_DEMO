CLASS zcl_sales_business DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    CLASS-DATA go_instance TYPE REF TO zcl_sales_business.
    CLASS-DATA gt_sales TYPE TABLE OF zdlrap_sales.

    CLASS-METHODS get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcl_sales_business.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_sales_business IMPLEMENTATION.

  METHOD get_instance.
    go_instance = ro_instance = COND #(
        WHEN go_instance IS BOUND THEN go_instance
        ELSE NEW #( )
    ).
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    " Inserir Status
    TYPES tt_sales TYPE TABLE OF zdlrap_sales WITH DEFAULT KEY.
    DATA(lt_sales) = VALUE tt_sales(
        ( orderid = '1' customer = 1 vendor = 2 company = 3 )
    ).
    MODIFY zdlrap_sales FROM TABLE lt_sales.
  ENDMETHOD.

ENDCLASS.
