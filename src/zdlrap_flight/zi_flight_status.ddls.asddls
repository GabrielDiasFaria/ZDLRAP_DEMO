@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic - Voos Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_FLIGHT_STATUS
  as select from zdl_flight_stat
{
      @EndUserText.label: 'Status'
  key id          as Id,
      @EndUserText.label: 'Descrição'
      description as Description
}
