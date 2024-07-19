@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic - Product'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PRODUCTS
  as select from zdlrap_products
{
  key productid     as Productid,
      description   as Description,
      @Semantics.amount.currencyCode : 'Currency'
      value         as Value,
      currency      as Currency,
      quantity      as Quantity,
      unity_measure as UnityMeasure
}
