// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// ---------------------------------------------------------------------------
// Example set for scenario 5b from the Richtlijn Gegevensuitwisseling Acute Zorg: an ambulance professional refers patient Patrick to the GP out-of-hours post (HAP) after on-scene care.
//
// Per the Nictiz FHIR R4 IG (section 2.6) the nl-core-derived resources declare both the use case profile and the nl-core parent in meta.profile, and references carry .type and .display (section 2.5).
// ---------------------------------------------------------------------------

Instance: hg-Patient-AmbulanceHAP-patrick
InstanceOf: HgPatientAmbulanceHAP
Usage: #example
Title: "Patient - Patrick (scenario 5b)"
Description: "Example patient (Patrick de Vries) referred from the ambulance to the GP out-of-hours post in scenario 5b."
* meta.profile[0] = "http://nictiz.nl/fhir/StructureDefinition/hg-Patient-AmbulanceHAP"
* meta.profile[+] = $nlcore-Patient
* identifier.system = $bsn
* identifier.value = "999999990"
* name.use = #official
* name.family = "de Vries"
* name.given = "Patrick"
// nl-core-NameInformation requires the iso21090-EN-qualifier (givenOrInitial) on each given name
* name.given[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier"
* name.given[0].extension[0].valueCode = #BR
* gender = #male
* birthDate = "1944-03-10"

Instance: hg-HealthProfessional-Practitioner-AmbulanceHAP-ambu
InstanceOf: Practitioner
Usage: #example
Title: "Practitioner - ambulance nurse"
Description: "Example ambulance nurse (the sending professional) for scenario 5b."
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.text = "A. Ambulance"

Instance: hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu
InstanceOf: HgHealthProfessionalPractitionerRoleAmbulanceHAP
Usage: #example
Title: "PractitionerRole - ambulance nurse"
Description: "Example PractitionerRole linking the ambulance nurse to the sending RAV organization for scenario 5b."
* meta.profile[0] = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthProfessional-PractitionerRole-AmbulanceHAP"
* meta.profile[+] = $nlcore-PractitionerRole
* practitioner = Reference(hg-HealthProfessional-Practitioner-AmbulanceHAP-ambu)
* practitioner.type = "Practitioner"
* practitioner.display = "A. Ambulance"
* organization = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-rav)
* organization.type = "Organization"
* organization.display = "RAV Utrecht"
* code.text = "Ambulanceverpleegkundige"

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-rav
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - Regionale Ambulancevoorziening"
Description: "Example sending organization (Regionale Ambulancevoorziening, RAV) for scenario 5b."
* meta.profile[0] = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
* meta.profile[+] = $nlcore-Organization
* identifier.system = $ura
* identifier.value = "00000001"
* name = "RAV Utrecht"

Instance: hg-HealthcareProvider-Organization-AmbulanceHAP-hap
InstanceOf: HgHealthcareProviderOrganizationAmbulanceHAP
Usage: #example
Title: "Organization - Huisartsenpost"
Description: "Example receiving organization (GP out-of-hours post, HAP) for scenario 5b."
* meta.profile[0] = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
* meta.profile[+] = $nlcore-Organization
* identifier.system = $ura
* identifier.value = "00000002"
* name = "Huisartsenpost Utrecht"

Instance: hg-ReferralServiceRequest-AmbulanceHAP-referral
InstanceOf: HgReferralServiceRequestAmbulanceHAP
Usage: #example
Title: "ServiceRequest - ambulance referral to HAP"
Description: "Example ambulance-to-HAP referral request (the focal resource) for scenario 5b."
* status = #completed
* intent = #order
* code = $sct#11131000146102 "overdracht van zorg vanuit ambulance"
* category[referralType] = $sct#308292007 "overdracht van zorg (verrichting)"
* subject = Reference(hg-Patient-AmbulanceHAP-patrick)
* subject.type = "Patient"
* subject.display = "Patrick de Vries"
* authoredOn = "2026-06-08T11:15:00+02:00"
* requester = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu)
* requester.type = "PractitionerRole"
* requester.display = "Ambulanceverpleegkundige (RAV Utrecht)"
* performer = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-hap)
* performer.type = "Organization"
* performer.display = "Huisartsenpost Utrecht"
* reasonCode.text = "Controleconsult gevraagd na ambulancezorg (maagklachten)."
* patientInstruction = "Maak een afspraak op de huisartsenpost voor een controleconsult."
* supportingInfo[0] = Reference(hg-ReferralComposition-AmbulanceHAP-referral)
* supportingInfo[0].type = "Composition"
* supportingInfo[0].display = "Ambulanceverwijzing naar huisartsenpost"
* supportingInfo[+] = Reference(hg-ReferralDocumentReference-AmbulanceHAP-ecg)
* supportingInfo[=].type = "DocumentReference"
* supportingInfo[=].display = "12-afleidingen ECG"

Instance: hg-ReferralComposition-AmbulanceHAP-referral
InstanceOf: HgReferralCompositionAmbulanceHAP
Usage: #example
Title: "Composition - ambulance transfer summary note"
Description: "Example tansfer summary note carrying the instituted treatment and the diagnosis/conclusion for scenario 5b."
* status = #final
* type = $loinc#18761-7 "Samenvatting van overdracht [bevinding] in {instelling} d.m.v. {rol} (document)"
* subject = Reference(hg-Patient-AmbulanceHAP-patrick)
* subject.type = "Patient"
* subject.display = "Patrick de Vries"
* date = "2026-06-08T11:15:00+02:00"
* author = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu)
* author.type = "PractitionerRole"
* author.display = "Ambulanceverpleegkundige (RAV Utrecht)"
* title = "Ambulanceverwijzing naar huisartsenpost"
// messageReason copies ServiceRequest.reasonCode.text (the same free text appears on the ServiceRequest for triage).
* section[messageReason]
  * title = "Reden van verwijzing"
  * code = $sct#440378000 "verwijzing voor (waarneembare entiteit)"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Controleconsult gevraagd na ambulancezorg (maagklachten).</div>"
* section[treatmentGiven]
  * title = "Ingestelde behandeling"
  * code = $loinc#18776-5 "Behandelplan [bevinding] in {instelling} d.m.v. {rol} (document)"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Antacidum toegediend, klachten verminderd.</div>"
* section[diagnosisConclusion]
  * title = "Diagnose/conclusie"
  * code = $loinc#55110-1 "Conclusies [interpretatie] (document)"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Waarschijnlijk maagklachten. Controle door huisarts gewenst.</div>"
// agreedWithPatient copies ServiceRequest.patientInstruction (the same text appears on the ServiceRequest for triage).
// LOINC 69730-0 has no Dutch designation, so the English display "Instructions" is used (the other LOINC section codes do have Dutch designations and use them); this validates under displayLanguage = nl because there is no nl designation to prefer.
* section[agreedWithPatient]
  * title = "Afspraken met patiënt"
  * code = $loinc#69730-0 "Instructions"
  * text.status = #additional
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Maak een afspraak op de huisartsenpost voor een controleconsult.</div>"

Instance: hg-ReferralDocumentReference-AmbulanceHAP-ecg
InstanceOf: HgReferralDocumentReferenceAmbulanceHAP
Usage: #example
Title: "DocumentReference - ECG attachment"
Description: "Example attached document (an ECG) accompanying the referral in scenario 5b."
* status = #current
// Document instance id (.id) and version-independent set id (.setId), folded onto identifier and told apart by the local type code. system = urn:oid:{II.root}, value = {II.extension}.
* identifier[documentId]
  * type = HgDocumentIdentifierType#document-id
  * system = "urn:oid:2.16.840.1.113883.2.4.3.11.60.103.4.145"
  * value = "20260608110500.ecg.1"
* identifier[documentSetId]
  * type = HgDocumentIdentifierType#document-set-id
  * system = "urn:oid:2.16.840.1.113883.2.4.3.11.60.103.4.145"
  * value = "20260608110500.ecg"
* extension[documentVersion].valueString = "1"
* type = $acutezorg-cs16#001 "12 afleidingen ECG"
* category.text = "Bijlage"
* author = Reference(hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu)
* author.type = "PractitionerRole"
* author.display = "Ambulanceverpleegkundige (RAV Utrecht)"
* content.attachment
  * contentType = #application/pdf
  * data = "JVBERi0xLjQK"
  * title = "12-afleidingen ECG"
  * creation = "2026-06-08T11:05:00+02:00"

Instance: hg-ReferralMessageHeader-AmbulanceHAP-referral
InstanceOf: HgReferralMessageHeaderAmbulanceHAP
Usage: #example
Title: "MessageHeader - ambulance referral"
Description: "Example MessageHeader focusing the referral ServiceRequest for the scenario 5b message."
* eventCoding = HgMessageEvent#145 "Verwijzing ambulance naar huisartsenpost"
* focus = Reference(hg-ReferralServiceRequest-AmbulanceHAP-referral)
* focus.type = "ServiceRequest"
* focus.display = "Ambulanceverwijzing naar huisartsenpost"
* sender = Reference(hg-HealthcareProvider-Organization-AmbulanceHAP-rav)
* sender.type = "Organization"
* sender.display = "RAV Utrecht"
* source.endpoint = "https://ambulance.example.nl/fhir"
* destination.endpoint = "https://hap.example.nl/fhir"

Instance: hg-ReferralBundle-AmbulanceHAP-referral
InstanceOf: HgReferralBundleAmbulanceHAP
Usage: #example
Title: "Bundle - ambulance referral message (scenario 5b)"
Description: "Example message Bundle containing the complete ambulance-to-HAP referral for scenario 5b."
* type = #message
* timestamp = "2026-06-08T11:15:05+02:00"
* entry[+].fullUrl = "http://nictiz.nl/fhir/MessageHeader/hg-ReferralMessageHeader-AmbulanceHAP-referral"
* entry[=].resource = hg-ReferralMessageHeader-AmbulanceHAP-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/ServiceRequest/hg-ReferralServiceRequest-AmbulanceHAP-referral"
* entry[=].resource = hg-ReferralServiceRequest-AmbulanceHAP-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/Composition/hg-ReferralComposition-AmbulanceHAP-referral"
* entry[=].resource = hg-ReferralComposition-AmbulanceHAP-referral
* entry[+].fullUrl = "http://nictiz.nl/fhir/Patient/hg-Patient-AmbulanceHAP-patrick"
* entry[=].resource = hg-Patient-AmbulanceHAP-patrick
* entry[+].fullUrl = "http://nictiz.nl/fhir/Practitioner/hg-HealthProfessional-Practitioner-AmbulanceHAP-ambu"
* entry[=].resource = hg-HealthProfessional-Practitioner-AmbulanceHAP-ambu
* entry[+].fullUrl = "http://nictiz.nl/fhir/PractitionerRole/hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu"
* entry[=].resource = hg-HealthProfessional-PractitionerRole-AmbulanceHAP-ambu
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-rav"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-rav
* entry[+].fullUrl = "http://nictiz.nl/fhir/Organization/hg-HealthcareProvider-Organization-AmbulanceHAP-hap"
* entry[=].resource = hg-HealthcareProvider-Organization-AmbulanceHAP-hap
* entry[+].fullUrl = "http://nictiz.nl/fhir/DocumentReference/hg-ReferralDocumentReference-AmbulanceHAP-ecg"
* entry[=].resource = hg-ReferralDocumentReference-AmbulanceHAP-ecg
