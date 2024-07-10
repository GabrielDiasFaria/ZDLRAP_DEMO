@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite - Voos Completos'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_FLIGHT_COMPLETE
  as select from ZI_FLIGHT
  association [1..1] to ZI_FLIGHT_STATUS as _Stats    on $projection.Status = _Stats.Id
  association [1..1] to ZI_FLIGHT_CITY   as _CityFrom on $projection.CityFrom = _CityFrom.Id
  association [1..1] to ZI_FLIGHT_CITY   as _CityTo   on $projection.CityTo = _CityTo.Id
{
  key Id,
      DepartureDate,
      ArrivalDate,
      CityFrom,
      _CityFrom.Description as CityFromDescription,
      CityTo,
      _CityTo.Description   as CityToDescription,
      Price,
      Waers,
      Status,
      _Stats.Description    as StatusDescription,
      
//    Icone
      @Semantics.imageUrl: true
      case when Status = 1 then 'sap-icon://lateness'
           when Status = 2 then 'sap-icon://accept'
           else 'sap-icon://decline' end as Icon,
           
      case when Status = 1 then 0
           when Status = 2 then 3
           else 1 end as Criticality,

      _Stats,
      _CityFrom,
      _CityTo
}
