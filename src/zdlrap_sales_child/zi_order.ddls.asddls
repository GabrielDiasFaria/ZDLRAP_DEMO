@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic - Ordem'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_ORDER
  as select from zdlrap_order
{
  key orderid               as Orderid,
      customer              as Customer,
      vendor                as Vendor,
      company               as Company,
      created_at            as CreatedAt,
      local_last_changed_at as LocalLastChangedAt
}
