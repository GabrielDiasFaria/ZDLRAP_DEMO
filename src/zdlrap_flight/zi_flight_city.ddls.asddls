@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic - Voos Cidades'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FLIGHT_CITY
  as select from zdl_flight_city
{
      @EndUserText.label: 'Cidade'
  key id          as Id,
      @EndUserText.label: 'Descrição'
      description as Description
}
