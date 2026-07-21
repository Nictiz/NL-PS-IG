// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation. Mappings to the ART-DECOR dataset "Verwijzing ambulance naar huisartsenpost" (id 2.16.840.1.113883.2.4.3.11.60.103.1.1, effectiveDate 2020-10-19). Per Nictiz profiling guidelines, mappings live on the use case layer.
//
// The underlying ART-DECOR dataset is shared across multiple use cases: element IDs (hg-dataelement-NNNN) are allocated once and reused across transactions. Not every element appears in every transaction. Where a mapping below covers an element that is defined in the shared dataset but not explicitly constrained in AMB-HAP transaction 4.145 (e.g. TypeBericht, Urgentie), it is included as a traceability link only. No further tightening is applied; the functional design describes the intended use.

Mapping: HgReferralServiceRequestAmbulanceHAPDataset
Source: HgReferralServiceRequestAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* -> "hg-dataelement-1673" "Envelop"
* status -> "hg-dataelement-5556" "Bestemmingsstatus"
// TypeBericht (1685): defined in the shared dataset; not explicitly modeled in AMB-HAP. Urgentie (1702): defined in the shared dataset; not explicitly modeled in AMB-HAP.
* subject -> "hg-dataelement-1676" "Patient"
* authoredOn -> "hg-dataelement-1684" "Datum en tijd"
* requester -> "hg-dataelement-5089" "Verzender"
* requester -> "hg-dataelement-5398" "Verzender (zorgverlener)"
* requester -> "hg-dataelement-5391" "Verzender (zorgaanbieder)"
* performer -> "hg-dataelement-1680" "Ontvanger"
// Ontvanger (zorgverlener) (5399) is intentionally not mapped: the HAP is addressed as an organization (zorgaanbieder, 5400), not as a named professional, so there is no PractitionerRole target for the receiver. This is asymmetric with the sender, which keeps 5398 (zorgverlener).
* performer -> "hg-dataelement-5400" "Ontvanger (zorgaanbieder)"
// RedenBericht and Context sit inside Kern in the dataset hierarchy. In FHIR, the reason for referral is placed on ServiceRequest.reasonCode and replicated inside the Composition.
* reasonCode -> "hg-dataelement-1872" "RedenBericht"
* reasonCode.text -> "hg-dataelement-1710" "Context"
* supportingInfo -> "hg-dataelement-1709" "Kern"
* supportingInfo -> "hg-dataelement-5457" "CommunicatieItem"
* patientInstruction -> "hg-dataelement-1752" "AfgesprokenMetPatient"

Mapping: HgReferralCompositionAmbulanceHAPDataset
Source: HgReferralCompositionAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* -> "hg-dataelement-1709" "Kern"
// The Composition represents the dataset's Kern (clinical core), so the root maps to Kern. subject, author and date are FHIR-mandatory document metadata that reuse the same Patient, Verzender and Datum en tijd the Envelop (ServiceRequest) carries, so they map to those Envelop-level dataelements rather than to Kern. This cross-container reuse is symmetric: the ServiceRequest root is the Envelop but it likewise surfaces Kern elements (RedenBericht, Context, AfgesprokenMetPatient) for early triage. The root is mapped to each resource's primary container only; the Composition is not separately mapped to Envelop because it represents the Kern, not the envelope.
* subject -> "hg-dataelement-1676" "Patient"
* author -> "hg-dataelement-5089" "Verzender"
* date -> "hg-dataelement-1684" "Datum en tijd"
// messageReason duplicates ServiceRequest.reasonCode: the section carries RedenBericht (1872) and its narrative carries the free-text Context (1710), mirroring the ServiceRequest mapping.
* section[messageReason] -> "hg-dataelement-1872" "RedenBericht"
* section[messageReason].text.div -> "hg-dataelement-1710" "Context"
* section[treatmentGiven].text.div -> "hg-dataelement-1711" "IngesteldeBehandeling"
* section[diagnosisConclusion].text.div -> "hg-dataelement-1749" "Diagnose/Conclusie"
// agreedWithPatient duplicates ServiceRequest.patientInstruction (also mapped to 1752 there).
* section[agreedWithPatient].text.div -> "hg-dataelement-1752" "AfgesprokenMetPatient"

Mapping: HgReferralDocumentReferenceAmbulanceHAPDataset
Source: HgReferralDocumentReferenceAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
// DocumentReference represents the folded CommunicatieItem wrapper (5457) and the Document it contains (5472). Both are mapped at root level.
* -> "hg-dataelement-5457" "CommunicatieItem"
* -> "hg-dataelement-5472" "Document"
* identifier[documentId] -> "hg-dataelement-5473" "DocumentIdentificatie"
* identifier[documentSetId] -> "hg-dataelement-5474" "DocumentSetIdentificatie"
* extension[documentVersion] -> "hg-dataelement-5475" "DocumentVersienummer"
* type -> "hg-dataelement-5554" "DocumentType"
* category -> "hg-dataelement-5463" "CommunicatieCategorie"
* content.attachment.contentType -> "hg-dataelement-5476" "DocumentBestandtype"
* content.attachment.data -> "hg-dataelement-5477" "DocumentInhoud"
* content.attachment.title -> "hg-dataelement-5552" "DocumentNaam"
* content.attachment.creation -> "hg-dataelement-5553" "DocumentCreatieDatumTijd"
// Known gaps: see 'Open items' in the IG.

Mapping: HgReferralMessageHeaderAmbulanceHAPDataset
Source: HgReferralMessageHeaderAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* sender -> "hg-dataelement-5089" "Verzender (transportniveau)"

Mapping: HgReferralBundleAmbulanceHAPDataset
Source: HgReferralBundleAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* timestamp -> "hg-dataelement-1684" "Datum en tijd (transportniveau)"

Mapping: HgPatientAmbulanceHAPDataset
Source: HgPatientAmbulanceHAP
Target: "https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39"
Id: hg-dataset-20201019
Title: "ART-DECOR Dataset Verwijzing ambulance naar huisartsenpost 2020-10-19"
* -> "hg-dataelement-1676" "Patient"
* contact -> "hg-dataelement-5309" "Contactpersoon"
