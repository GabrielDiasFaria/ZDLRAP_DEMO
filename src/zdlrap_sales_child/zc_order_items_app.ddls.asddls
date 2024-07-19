@EndUserText.label: 'Composite - Vendas Frente Caixa'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true
define view entity ZC_ORDER_ITEMS_APP
  as projection on ZI_ORDER_ITEMS_APP
{
  key Orderid,
  key Item,
      @ObjectModel.text.element: [ 'Description' ]   
      Product,
      Description,
      Value,
      Currency,
      Quantity,
      SalesPrice,
      UnityMeasure,
      /* Associations */
      _Order: redirected to parent ZC_ORDER_APP,
      _Product
}
