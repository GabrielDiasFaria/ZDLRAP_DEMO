@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite - Sales'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_SALES_COMPLETE
  as select from ZI_SALES
{
  key Orderid,
      Customer,
      Vendor,
      Company,
      CreatedAt,
      LocalLastChangedAt
}
