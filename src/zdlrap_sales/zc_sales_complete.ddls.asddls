@EndUserText.label: 'Comsumption - Sales'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true
define root view entity ZC_SALES_COMPLETE
  as projection on ZI_SALES_COMPLETE
{
  key Orderid,
      Customer,
      Vendor,
      Company,
      CreatedAt,
      LocalLastChangedAt
}
