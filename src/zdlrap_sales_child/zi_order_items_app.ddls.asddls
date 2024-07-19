@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite - Vendas Frente Caixa'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_ORDER_ITEMS_APP
  as select from ZI_ORDER_IT
  association to parent ZI_ORDER_APP as _Order on $projection.Orderid = _Order.Orderid
  association [1..1] to ZI_PRODUCTS as _Product on $projection.Product = _Product.Productid
{
  key Orderid,
  key Item,
      Product,
      _Product.Description,
      _Product.Value,
      _Product.Currency,
      Quantity,
      cast(_Product.Value as abap.dec( 10, 2 )) * 
      cast(Quantity as abap.dec(10,2)) as SalesPrice,
      UnityMeasure,
      
      _Order,
      _Product
}
