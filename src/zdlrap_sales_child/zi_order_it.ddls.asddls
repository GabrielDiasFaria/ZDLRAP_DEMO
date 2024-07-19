@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic - Ordem Itens'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_ORDER_IT
  as select from zdlrap_order_it
{
  key orderid       as Orderid,
  key item          as Item,
      product       as Product,
      quantity      as Quantity,
      unity_measure as UnityMeasure
}
