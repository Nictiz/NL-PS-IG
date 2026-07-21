// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Minimal example, modelled on the ART-DECOR ADA test instance
// "az-ave-tst-3-minimaalTestdag" (Ambulanceverwijzing, app hg-1.0.0): a lean
// ambulance-to-HAP referral with only the essentials - a patient known by name
// and gender (no identifier), the sending and receiving organizations addressed
// by URA, a free-text reason, and the ambulance report attachment.
//
// Values follow the ADA test data (test values only). The organization name and
// the URA value are filled in here because this IG's profiles make them
// mandatory, whereas the ART-DECOR minimal test leaves them empty - a small
// ART-DECOR-to-FHIR cardinality mismatch (see Open Items, issue #5).
//
// Note: this is a hand-authored interpretation of the ADA instance, not output
// of the usual ADA-to-FHIR tooling (not yet available for this transaction).
// See the Testing page; the examples are provisional pending that tooling.
//
// Per the Nictiz FHIR R4 IG, the nl-core-derived resources declare both the use
// case profile and the nl-core parent in meta.profile (section 2.6), and
// references carry .type and .display (section 2.5).
// ---------------------------------------------------------------------------

Instance: hg-Patient-AmbulanceHAP-min
InstanceOf: HgPatientAmbulanceHAP
Usage: #example
Title: "Patient - Bakkersz (minimal example)"
Description: "Example patient for the minimal ambulance-to-HAP referral (ART-DECOR ADA test az-ave-tst-3-minimaalTestdag): known only by family name and the mandatory gender, with no identifier. The name alone satisfies the patient-identifiable rule (hg-pat-1)."
* meta.profile[0] = "http://nictiz.nl/fhir/StructureDefinition/hg-Patient-AmbulanceHAP"
* meta.profile[+] = $nlcore-Patient
* name.use = #official
* name.text = "Bakkersz"
* name.family = "Bakkersz"
* gender = #female

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-min-rav
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - RAV (minimal example)"
Description: "Example sending organization (Regionale Ambulancevoorziening) for the minimal ambulance-to-HAP referral, addressed by URA."
* meta.profile[0] = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
* meta.profile[+] = $nlcore-Organization
* identifier.system = $ura
* identifier.value = "00000001"
* name = "RAV"

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-min-hap
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - HAP (minimal example)"
Description: "Example receiving organization (huisartsenpost) for the minimal ambulance-to-HAP referral, addressed by URA."
* meta.profile[0] = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
* meta.profile[+] = $nlcore-Organization
* identifier.system = $ura
* identifier.value = "00000002"
* name = "HAP"

Instance: hg-ReferralServiceRequest-AmbulanceHAP-min
InstanceOf: HgReferralServiceRequestAmbulanceHAP
Usage: #example
Title: "ServiceRequest - minimal ambulance referral"
Description: "Minimal example ambulance-to-HAP referral request (ART-DECOR ADA test az-ave-tst-3-minimaalTestdag): the mandatory elements plus the free-text reason and the links to the Composition core and the document attachment. The optional sender and patient instruction are omitted."
* status = #completed
* intent = #order
* code = $sct#11131000146102 "overdracht van zorg vanuit ambulance"
* category[referralType] = $sct#308292007 "overdracht van zorg (verrichting)"
* subject = Reference(hg-Patient-AmbulanceHAP-min)
* subject.type = "Patient"
* subject.display = "Bakkersz"
* authoredOn = "2026-06-15T09:30:00+02:00"
* performer = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-min-hap)
* performer.type = "Organization"
* performer.display = "HAP"
* reasonCode.text = "Lage rugklachten, graag uw beoordeling."
* supportingInfo[0] = Reference(hg-ReferralComposition-AmbulanceHAP-min)
* supportingInfo[0].type = "Composition"
* supportingInfo[0].display = "Ambulanceverwijzing naar huisartsenpost"
* supportingInfo[+] = Reference(hg-ReferralDocumentReference-AmbulanceHAP-min)
* supportingInfo[=].type = "DocumentReference"
* supportingInfo[=].display = "ambulanceverslag"

Instance: hg-ReferralComposition-AmbulanceHAP-min
InstanceOf: HgReferralCompositionAmbulanceHAP
Usage: #example
Title: "Composition - minimal transfer summary note"
Description: "Minimal example transfer summary note: the mandatory metadata and the single mandatory section (messageReason). The optional treatment, diagnosis/conclusion and agreed-with-patient sections are omitted."
* status = #final
* type = $loinc#18761-7 "Samenvatting van overdracht [bevinding] in {instelling} d.m.v. {rol} (document)"
* subject = Reference(hg-Patient-AmbulanceHAP-min)
* subject.type = "Patient"
* subject.display = "Bakkersz"
* date = "2026-06-15T09:30:00+02:00"
* author = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-min-rav)
* author.type = "Organization"
* author.display = "RAV"
* title = "Ambulanceverwijzing naar huisartsenpost"
* section[messageReason]
  * title = "Reden van verwijzing"
  * code = $sct#440378000 "verwijzing voor (waarneembare entiteit)"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Lage rugklachten, graag uw beoordeling.</div>"

Instance: hg-ReferralDocumentReference-AmbulanceHAP-min
InstanceOf: HgReferralDocumentReferenceAmbulanceHAP
Usage: #example
Title: "DocumentReference - ambulance report attachment (minimal example)"
Description: "Example attached document (the ambulance report PDF) accompanying the minimal ambulance-to-HAP referral."
* status = #current
* identifier[documentId]
  * type = HgDocumentIdentifierType#document-id
  * system = "urn:oid:2.16.840.1.113883.2.4.3.11.999.103.2"
  * value = "87946546"
* identifier[documentSetId]
  * type = HgDocumentIdentifierType#document-set-id
  * system = "urn:oid:2.16.840.1.113883.2.4.3.11.999.103.2"
  * value = "16456435"
* extension[documentVersion].valueString = "1"
* type = $acutezorg-cs16#006 "intern rapport/overdracht"
* category.text = "Bijlage"
* author = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-min-rav)
* author.type = "Organization"
* author.display = "RAV"
* content.attachment
  * contentType = #application/pdf
  * data = "JVBERi0xLjQK"
  * title = "ambulanceverslag"
  * creation = "2026-06-15T09:20:00+02:00"

Instance: hg-ReferralMessageHeader-AmbulanceHAP-min
InstanceOf: HgReferralMessageHeaderAmbulanceHAP
Usage: #example
Title: "MessageHeader - minimal ambulance referral"
Description: "Example MessageHeader: the fixed event, the focal ServiceRequest, the sending organization and the message source."
* eventCoding = HgMessageEvent#145 "Verwijzing ambulance naar huisartsenpost"
* focus = Reference(hg-ReferralServiceRequest-AmbulanceHAP-min)
* focus.type = "ServiceRequest"
* focus.display = "Ambulanceverwijzing naar huisartsenpost"
* sender = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-min-rav)
* sender.type = "Organization"
* sender.display = "RAV"
* source.endpoint = "https://ambulance.example.nl/fhir"

Instance: hg-ReferralBundle-AmbulanceHAP-min
InstanceOf: HgReferralBundleAmbulanceHAP
Usage: #example
Title: "Bundle - minimal ambulance referral message"
Description: "Minimal example message Bundle for an ambulance-to-HAP referral (ART-DECOR ADA test az-ave-tst-3-minimaalTestdag): patient, the two organizations, the referral, the transfer note and the document attachment."
* type = #message
* timestamp = "2026-06-15T09:30:05+02:00"
* entry[+].fullUrl = "http://nictiz.nl/fhir/MessageHeader/hg-ReferralMessageHeader-AmbulanceHAP-min"
* entry[=].resource = hg-ReferralMessageHeader-AmbulanceHAP-min
* entry[+].fullUrl = "http://nictiz.nl/fhir/ServiceRequest/hg-ReferralServiceRequest-AmbulanceHAP-min"
* entry[=].resource = hg-ReferralServiceRequest-AmbulanceHAP-min
* entry[+].fullUrl = "http://nictiz.nl/fhir/Composition/hg-ReferralComposition-AmbulanceHAP-min"
* entry[=].resource = hg-ReferralComposition-AmbulanceHAP-min
* entry[+].fullUrl = "http://nictiz.nl/fhir/Patient/hg-Patient-AmbulanceHAP-min"
* entry[=].resource = hg-Patient-AmbulanceHAP-min
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-min-rav"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-min-rav
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-min-hap"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-min-hap
* entry[+].fullUrl = "http://nictiz.nl/fhir/DocumentReference/hg-ReferralDocumentReference-AmbulanceHAP-min"
* entry[=].resource = hg-ReferralDocumentReference-AmbulanceHAP-min
