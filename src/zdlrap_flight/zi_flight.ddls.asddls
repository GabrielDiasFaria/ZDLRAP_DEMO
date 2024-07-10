@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic - Voos'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FLIGHT
  as select from zdl_flight
{
  key id             as Id,
      departure_date as DepartureDate,
      arrival_date   as ArrivalDate,
      city_from      as CityFrom,
      city_to        as CityTo,
      @Semantics.amount.currencyCode : 'waers'
      price          as Price,
      waers          as Waers,
      status         as Status
}
