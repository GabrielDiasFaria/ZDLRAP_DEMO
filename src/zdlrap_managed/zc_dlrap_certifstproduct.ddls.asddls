@EndUserText.label: 'Consumption - Certificados Status'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_DLRAP_CERTIFSTPRODUCT
  as projection on ZI_DLRAP_CERTIFSTPRODUCT
{
  key StateUuid,
      CertUuid, 
      Matnr,
      Description,
      Version,
      Status,
      StatusOld,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Certif: redirected to parent ZC_DLRAP_CERTIFPRODUCT
}
