@EndUserText.label: 'Consumption - Vendas'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true
define root view entity ZC_ORDER_APP
  as projection on ZI_ORDER_APP
{
  key Orderid,
      Customer,
      Vendor,
      Company,
      CreatedAt,
      LocalLastChangedAt,
      /* Associations */
      _Items: redirected to composition child ZC_ORDER_ITEMS_APP
}
