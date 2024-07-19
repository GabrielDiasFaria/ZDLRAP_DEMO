@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite - Vendas Frente Caixa'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_ORDER_APP
  as select from ZI_ORDER
  composition [1..*] of ZI_ORDER_ITEMS_APP as _Items
{
  key Orderid,
      Customer,
      Vendor,
      Company,
      CreatedAt,
      LocalLastChangedAt,
      
      _Items
}
