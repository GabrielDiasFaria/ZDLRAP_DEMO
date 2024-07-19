CLASS lhc_Order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Order RESULT result.

    METHODS earlynumbering_cba_Items FOR NUMBERING
      IMPORTING entities FOR CREATE Order\_Items.

ENDCLASS.

CLASS lhc_Order IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_cba_Items.

    LOOP AT entities INTO DATA(entity).
      LOOP AT entity-%target ASSIGNING FIELD-SYMBOL(<fs_target>).
        SELECT MAX( item )
            FROM zdlrap_order_it
            WHERE orderid = @entity-Orderid
            INTO @DATA(lv_last_item).

        DATA(lv_next_item) = lv_last_item + 1.

        INSERT VALUE #(
            %cid    = <fs_target>-%cid
            OrderId = <fs_target>-Orderid
            Item    = lv_next_item
        ) INTO TABLE mapped-items.
      ENDLOOP.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
