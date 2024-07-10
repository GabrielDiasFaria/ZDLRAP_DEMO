@EndUserText.label: 'Consumption - Voos'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true

@Metadata.allowExtensions: true
define root view entity ZC_FLIGHT_COMPLETE
  as projection on ZI_FLIGHT_COMPLETE
{
      @Search.defaultSearchElement: true
  key Id,
      @Consumption.filter: { selectionType: #INTERVAL }
      DepartureDate,
      @Consumption.filter: { selectionType: #INTERVAL }
      ArrivalDate,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_FLIGHT_CITY', element: 'Id' } }]
      @ObjectModel.text.element: [ 'CityFromDescription' ]     
      CityFrom,
      @Search.defaultSearchElement: true
      CityFromDescription,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_FLIGHT_CITY', element: 'Id' } }]
      @ObjectModel.text.element: [ 'CityToDescription' ]      
      CityTo,
      @Search.defaultSearchElement: true
      CityToDescription,
      Price,
      Waers,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_FLIGHT_STATUS', element: 'Id' } }]
      @ObjectModel.text.element: [ 'StatusDescription' ]
      Status,
      StatusDescription,
      Icon,
      Criticality,
      /* Associations */
      _CityFrom,
      _CityTo,
      _Stats
}
