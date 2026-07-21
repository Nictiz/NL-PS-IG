// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Use case layer: Ambulanceverwijzing (AMB -> HAP, message 24). Derives from the generic hg-Referral profiles, tightens cardinalities, applies obligations (in place of mustSupport) and fixes the message event. Dataset mappings live here (see DatasetMappings.fsh). Reference targets keep the core resource type alongside the transaction-specific zib profile, so the model stays open-world.
//
// Style: caret rules (^short/^alias/^definition/^comment/^slicing) are grouped under their element via indentation; cardinality, only, from, contains and insert stay at column 0.
// =============================================================================

// Implementer guidance for the narrative-only sections (text.status fixed to #additional). Inserted on each section's text element so it renders on the profile page.
RuleSet: SectionNarrativeComment
* ^comment = "This section conveys its *rubriek* as free text. `text.status` is fixed to `additional` because the narrative is the source of this information, not a rendering generated from structured data: there is no expectation that `Composition.section.entry` will be populated here. The `text.div` may contain plain text or the limited xhtml subset that the FHIR specification allows for a Narrative."

// Documentation note for content that is also carried on the referral ServiceRequest. Inserted on the Composition sections that duplicate a ServiceRequest value.
RuleSet: CopiedFromServiceRequestComment
* ^comment = "This content originates on the referral `ServiceRequest`, which is always the authoritative source. The `ServiceRequest` carries it so the receiving system can triage the referral early; the same value is copied into this Composition section so it is documented and persisted in the receiving system's record. The `ServiceRequest` value remains authoritative - this section is a documentation copy."

Profile: HgReferralServiceRequestAmbulanceHAP
Parent: HgReferralServiceRequest
Id: hg-ReferralServiceRequest-AmbulanceHAP
Title: "hg referral ServiceRequest - Ambulance to HAP"
Description: "Ambulance to GP out-of-hours post (HAP) referral request (Ambulanceverwijzing, AMB naar HAP, message 24)."
* . ^short = "Envelope"
  * ^alias[0] = "Envelop"
  * ^definition = "Geeft alle relevante gegevens in de envelop conform de richtlijn."
* status 1..1
  * ^short = "DestinationStatus"
  * ^alias[0] = "Bestemmingsstatus"
  * ^definition = "Geeft de status van de ambulance naar deze bestemming. De waarden zijn: Actief = patiënt is onderweg naar de bestemming. Geannuleerd = patiënt gaat niet meer naar de bestemming. Dit is het laatste bericht van de ambulance naar de bestemming. Overgedragen = patiënt is overgedragen aan de bestemming. Dit is het laatste bericht van de ambulance naar de bestemming."
  * ^comment = "Bestemmingsstatus value mapping to ServiceRequest.status (request-status): Actief = active; Geannuleerd = revoked (FHIR R4 uses 'revoked' where ART-DECOR/STU3 used 'cancelled'); Overgedragen = completed."
* status from HgDestinationStatus (required)
* status insert ObligationMandatory
* intent 1..1
* intent insert ObligationMandatory
* code = $sct#11131000146102
* category ^slicing.discriminator[0].type = #pattern
  * ^slicing.discriminator[0].path = "$this"
  * ^slicing.rules = #open
  * ^short = "MessageType"
  * ^alias[0] = "TypeBericht"
  * ^definition = "Geeft het type bericht dat verstuurd wordt door de verzender."
* category contains referralType 1..1
* category[referralType] = $sct#308292007
* category insert ObligationMandatory
* subject 1..1
  * ^short = "Patient"
  * ^alias[0] = "Patient"
  * ^definition = "Geeft de gegevens van de patiënt en de eventuele gegevens over de contactpersonen van de patiënt."
* subject only Reference(Patient or HgPatientAmbulanceHAP)
* subject insert ObligationMandatory
* authoredOn 1..1
  * ^short = "SendDateTime"
  * ^alias[0] = "Datum en tijd"
  * ^definition = "Geeft het tijdstip waarop de verzender het bericht afrondt en aanbiedt voor verzending."
* authoredOn insert ObligationMandatory
* requester 0..1
  * ^short = "Sender"
  * ^alias[0] = "Verzender"
  * ^alias[1] = "Zorgverlener"
  * ^alias[2] = "Zorgaanbieder"
  * ^definition = "Geeft de volledige identificatie- en contactgegevens van de verzender van het bericht."
* requester only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* requester insert Obligation
* performer 1..1
  * ^short = "Recipient"
  * ^alias[0] = "Ontvanger"
  * ^alias[1] = "Zorgverlener"
  * ^alias[2] = "Zorgaanbieder"
  * ^definition = "Geeft de volledige identificatie- en contactgegevens van de ontvanger van het bericht."
* performer only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* performer insert ObligationMandatory
* reasonCode 1..1
  * ^short = "MessageReason"
  * ^alias[0] = "RedenBericht"
  * ^alias[1] = "Context"
  * ^definition = "Geeft de reden van de verwijzing of de update. Hierbij is de beschrijving als vrije tekst op aangeven van het NHG verplicht. Daarnaast kan er ook een ICPC-code van de episode worden meegestuurd, al dan niet aangevuld met meer details over de vastlegging van de ICPC. De ambulance legt de reden altijd vast in vrije tekst."
* reasonCode insert ObligationMandatory
// The NHG mandates the free-text description; coding (ICPC) stays optional and is left unconstrained here (see the Open Items page).
* reasonCode.text 1..1
* supportingInfo 1..*
  * ^short = "Core"
  * ^alias[0] = "Kern"
  * ^alias[1] = "CommunicatieItem"
  * ^definition = "Geeft de zorginhoudelijke kerngegevens van de berichten die worden uitgewisseld."
* supportingInfo only Reference(Resource or HgReferralCompositionAmbulanceHAP or HgReferralDocumentReferenceAmbulanceHAP)
* supportingInfo insert ObligationMandatory
* patientInstruction 0..1
  * ^short = "AgreedWithPatient"
  * ^alias[0] = "AfgesprokenMetPatient"
  * ^definition = "In de uitwisseling Ambulance - HAP vanuit de richtlijn NHG - Acute Zorg wordt dit veld gemapt op het veld 'Afspraken met patiënt'."
* patientInstruction insert Obligation

Profile: HgReferralCompositionAmbulanceHAP
Parent: HgReferralComposition
Id: hg-ReferralComposition-AmbulanceHAP
Title: "hg referral Composition - Ambulance to HAP"
Description: "Transfer summary note for the ambulance to GP out-of-hours post (HAP) referral."
* . ^short = "Core"
  * ^alias[0] = "Kern"
  * ^definition = "Geeft de zorginhoudelijke kerngegevens van de berichten die worden uitgewisseld."
* type = $loinc#18761-7
* status 1..1
* status insert ObligationMandatory
* subject 1..1
  * ^short = "Patient"
  * ^alias[0] = "Patient"
  * ^definition = "Geeft de gegevens van de patiënt en de eventuele gegevens over de contactpersonen van de patiënt."
* subject only Reference(Patient or HgPatientAmbulanceHAP)
* subject insert ObligationMandatory
* author 1..1
  * ^short = "Sender"
  * ^alias[0] = "Verzender"
  * ^definition = "Geeft de volledige identificatie- en contactgegevens van de verzender van het bericht."
* author only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* author insert ObligationMandatory
* date 1..1
* date insert ObligationMandatory
* title 1..1
* title insert ObligationMandatory
// Re-declare the section slicing (inherited from the generic parent) so the snapshot generator anchors the slice child elements (.code, .text) in this profile.
* section ^slicing.discriminator[0].type = #pattern
  * ^slicing.discriminator[0].path = "code"
  * ^slicing.rules = #open
* section contains messageReason 1..1 and treatmentGiven 0..* and diagnosisConclusion 0..1 and agreedWithPatient 0..1
// The free-text content of each rubriek is carried in the section's own narrative (Composition.section.text). text.status is fixed to #additional and text is required (1..1) with the populate-if-known obligation; the SectionNarrativeComment RuleSet (above) renders the rationale on the profile page.
// messageReason duplicates ServiceRequest.reasonCode (RedenBericht 1872; the free-text Context 1710 is its narrative). The section is 1..1 because reasonCode is mandatory and is always copied here for documentation. See CopiedFromServiceRequestComment for the origin/triage rationale.
* section[messageReason] ^short = "MessageReason"
  * ^alias[0] = "RedenBericht"
  * ^alias[1] = "Context"
  * ^definition = "Geeft de reden van de verwijzing of de update. De ambulance legt de reden altijd vast in vrije tekst."
* section[messageReason].code = $sct#440378000
* section[messageReason] insert ObligationMandatory
* section[messageReason] insert CopiedFromServiceRequestComment
* section[messageReason].text 1..1
* section[messageReason].text.status = #additional
* section[messageReason].text insert ObligationMandatory
* section[messageReason].text insert SectionNarrativeComment
* section[treatmentGiven] ^short = "SetTreatment"
  * ^alias[0] = "IngesteldeBehandeling"
  * ^definition = "Geeft de ingestelde behandeling in het verwijsbericht, de update en het DT-bericht."
* section[treatmentGiven].code = $loinc#18776-5
* section[treatmentGiven] insert Obligation
* section[treatmentGiven].text 1..1
* section[treatmentGiven].text.status = #additional
* section[treatmentGiven].text insert ObligationMandatory
* section[treatmentGiven].text insert SectionNarrativeComment
* section[diagnosisConclusion] ^short = "DiagnosisConclusion"
  * ^alias[0] = "Diagnose/Conclusie"
  * ^definition = "Geeft de diagnose en/of conclusie."
* section[diagnosisConclusion].code = $loinc#55110-1
* section[diagnosisConclusion] insert Obligation
* section[diagnosisConclusion].text 1..1
* section[diagnosisConclusion].text.status = #additional
* section[diagnosisConclusion].text insert ObligationMandatory
* section[diagnosisConclusion].text insert SectionNarrativeComment
// agreedWithPatient duplicates ServiceRequest.patientInstruction (AfgesprokenMetPatient 1752). It is 0..1 because patientInstruction is optional; copied here for documentation. See CopiedFromServiceRequestComment for the origin/triage rationale.
* section[agreedWithPatient] ^short = "AgreedWithPatient"
  * ^alias[0] = "AfgesprokenMetPatient"
  * ^definition = "In de uitwisseling Ambulance - HAP vanuit de richtlijn NHG - Acute Zorg wordt dit veld gemapt op het veld 'Afspraken met patiënt'."
* section[agreedWithPatient].code = $loinc#69730-0
* section[agreedWithPatient] insert Obligation
* section[agreedWithPatient] insert CopiedFromServiceRequestComment
* section[agreedWithPatient].text 1..1
* section[agreedWithPatient].text.status = #additional
* section[agreedWithPatient].text insert ObligationMandatory
* section[agreedWithPatient].text insert SectionNarrativeComment

Profile: HgReferralDocumentReferenceAmbulanceHAP
Parent: HgReferralDocumentReference
Id: hg-ReferralDocumentReference-AmbulanceHAP
Title: "hg referral DocumentReference - Ambulance to HAP"
Description: "Attached document for the ambulance to GP out-of-hours post (HAP) referral. The folded CommunicatieItem category and sender (as modeled in ART-DECOR) are carried on `category` and `author`."
* . ^short = "CommunicationItem"
  * ^alias[0] = "CommunicatieItem"
  * ^comment = "This DocumentReference represents the folded *CommunicatieItem* wrapper (hg-dataelement-5457) and the *Document* it contains (hg-dataelement-5472); both are mapped at root level. The attached document and its constraints (DocumentType bound to the Bijlagen/BSA list, PDF content) follow the [document specification for the Ambulanceverwijzing](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Specificatie_van_het_document_binnen_de_Ambulanceverwijzing_naar_de_Huisartsenpost) in the Nictiz functional design, and should be kept aligned with it as that specification is finalized."
// masterIdentifier is removed in R5/R6 (folded into identifier); the document and set ids are carried on the identifier slices defined in the generic layer. See the Design Decisions page.
* masterIdentifier 0..0
* identifier[documentId] 1..1
  * ^short = "DocumentIdentification"
  * ^alias[0] = "DocumentIdentificatie"
  * ^definition = "Het identificatienummer van het document."
* identifier[documentId] insert ObligationMandatory
* identifier[documentSetId] 1..1
  * ^short = "DocumentSetIdentification"
  * ^alias[0] = "DocumentSetIdentificatie"
  * ^definition = "Identificatienummer van de set waar het document toe behoort."
  * ^comment = "1..1: the dataset element DocumentSetIdentificatie (hg-dataelement-5474) prescribes a set identifier on every document, so it is required here, even though CDA externalDocument.setId is optional in the general CDA model."
* identifier[documentSetId] insert ObligationMandatory
* extension[documentVersion] 0..1
  * ^short = "DocumentVersion"
  * ^alias[0] = "DocumentVersienummer"
* extension[documentVersion] insert Obligation
* type 1..1
  * ^short = "DocumentType"
  * ^alias[0] = "DocumentType"
  * ^definition = "Geeft aan welk type document is toegevoegd. Op dit moment is de BSA lijst gekoppeld vanuit de Ambulance."
* type from $vs-bijlagen (required)
* type insert ObligationMandatory
* category ^short = "CommunicationCategory"
  * ^alias[0] = "CommunicatieCategorie"
  * ^comment = "Maps to dataset element CommunicatieCategorie (hg-dataelement-5463). No value set is bound yet - the terminology is still open (see the Open Items page)."
* category insert Obligation
* author 1..1
  * ^short = "CommunicationSender"
  * ^alias[0] = "CommunicatieAfzender"
* author only Reference(PractitionerRole or Organization or HgHealthProfessionalPractitionerRoleAmbulanceHAP or HgHealthcareProviderOrganizationAmbulanceHAP)
* author insert ObligationMandatory
* content.attachment.contentType 1..1
  * ^short = "DocumentMediaType"
  * ^alias[0] = "DocumentBestandtype"
  * ^definition = "Het bestandtype als mimetype, bijvoorbeeld \"application/pdf\" of \"text/plain\". Voor de verwijzing vanuit de Ambulance naar de Huisarts of Huisartsenpost is dit een pdf."
* content.attachment.contentType insert ObligationMandatory
* content.attachment.data 1..1
  * ^short = "DocumentContent"
  * ^alias[0] = "DocumentInhoud"
  * ^definition = "Geeft de inhoud van de bijlage (blob)."
* content.attachment.data insert ObligationMandatory
* content.attachment.title 1..1
  * ^short = "DocumentName"
  * ^alias[0] = "DocumentNaam"
  * ^definition = "De bestandsnaam die het document heeft bij de verzender."
* content.attachment.title insert ObligationMandatory
* content.attachment.creation ^short = "DocumentCreationDateTime"
  * ^alias[0] = "DocumentCreatieDatumTijd"
  * ^definition = "Datum van het aanmaken van het document."
* content.attachment.creation insert Obligation

Profile: HgReferralMessageHeaderAmbulanceHAP
Parent: HgReferralMessageHeader
Id: hg-ReferralMessageHeader-AmbulanceHAP
Title: "hg referral MessageHeader - Ambulance to HAP"
Description: "MessageHeader for the ambulance to GP out-of-hours post (HAP) referral PUSH."
* eventCoding = HgMessageEvent#145
* focus 1..1
* focus only Reference(HgReferralServiceRequestAmbulanceHAP)
* focus insert ObligationMandatory
* sender 1..1
* sender only Reference(Organization or HgHealthcareProviderOrganizationAmbulanceHAP)
* sender insert ObligationMandatory
* source 1..1

Profile: HgReferralBundleAmbulanceHAP
Parent: HgReferralBundle
Id: hg-ReferralBundle-AmbulanceHAP
Title: "hg referral Bundle - Ambulance to HAP"
Description: "Message bundle for the ambulance to GP out-of-hours post (HAP) referral PUSH."
* type = #message
* timestamp 1..1
* entry 1..*
* entry.fullUrl 1..1
* entry.resource 1..1
