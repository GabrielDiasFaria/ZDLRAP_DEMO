@EndUserText.label: 'Consumption - Certificados'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_DLRAP_CERTIFPRODUCT
  as projection on ZI_DLRAP_CERTIFPRODUCT
{
  key CertUuid,
      Matnr,
      Description, 
      Version,
      CertStatus, 
      CertCe,
      CertGs,
      CertFcc,
      CertIso,
      CertTuev,
      LocalLastChangedAt,
      Icon,
      /* Associations */
      _Prod,
      _Stats: redirected to composition child ZC_DLRAP_CERTIFSTPRODUCT
}
