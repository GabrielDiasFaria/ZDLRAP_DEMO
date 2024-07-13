@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZI_SALES
  as select from zdlrap_sales
{
  key orderid               as Orderid,
      customer              as Customer,
      vendor                as Vendor,
      company               as Company,
      created_at            as CreatedAt,
      local_last_changed_at as LocalLastChangedAt
}
