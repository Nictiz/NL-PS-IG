// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Generic referral layer (open world, FHIR core based, no mustSupport). Reusable across the Acute Zorg referral use cases. Use case profiles derive from these and add cardinalities, mustSupport and dataset mappings.
//
// Dependency note: the nictiz.fhir.nl.r4.elz package references these profiles. The correct dependency direction is ELZ -> Acute Zorg, not the reverse. These profiles belong here as the core of the Acute Zorg umbrella IG; moving them to ELZ would invert ownership, introduce ELZ beta instability into this IG, and risk a circular dependency. If ELZ needs a stable anchor, it should pin to a released version of nictiz.fhir.nl.r4.acutezorg.
// =============================================================================

// Implementer guidance for references that point to a party (a health professional and/or a healthcare provider organization). Because ElementDefinition.comment is single-valued, the two pieces of guidance below are combined into one RuleSet rather than two: an element cannot carry two separate comments, and every reference that names a PractitionerRole here also names an Organization. Inserted on requester, performer, author and sender. 1. zib HealthProfessional (guideline 13.2.2): reference the PractitionerRole as the entry point (it resolves to the Practitioner); keep base Practitioner/PractitionerRole open and do NOT add nl-core-HealthProfessional-Practitioner as a target profile. 2. zib HealthcareProvider: reference nl-core-HealthcareProvider-Organization directly, not the nl-core-HealthcareProvider (Location) focal resource - see the Design Decisions page.
RuleSet: PartyReferenceComment
* ^comment = """Each occurrence of the zib HealthProfessional is normally represented by _two_ FHIR resources: a PractitionerRole resource (instance of [nl-core-HealthProfessional-PractitionerRole](http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole)) and a Practitioner resource (instance of [nl-core-HealthProfessional-Practitioner](http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner)). The Practitioner resource is referenced from the PractitionerRole instance. For this reason, sending systems should fill the reference to the PractitionerRole instance here, and not the Practitioner resource. Receiving systems can then retrieve the reference to the Practitioner resource from that PractitionerRole instance. In rare circumstances, there is only a Practitioner instance, in which case it is that instance which will be referenced here. However, since this should be the exception, the nl-core-HealthProfessional-Practitioner profile is not explicitly mentioned as a target profile.

Where the zib HealthcareProvider (_zorgaanbieder_) is referenced, the [nl-core-HealthcareProvider-Organization](http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization) profile is referenced directly, not the nl-core-HealthcareProvider (Location) focal resource. nl-core makes Location the focal resource of the zib because most references concern the physical location where care takes place; here the reference concerns the organizational identity (addressing) of the party and carries no care-location data, so the Organization profile is referenced directly. See the Design Decisions page."""

Profile: HgReferralServiceRequest
Parent: ServiceRequest
Id: hg-ReferralServiceRequest
Title: "hg referral ServiceRequest"
Description: "Generic referral request (workflow 'request' on FHIR core ServiceRequest) for Acute Zorg referrals. Open-world: nl-core targets are added next to the base resources; cardinalities and mustSupport are left to the use case layer."
// status: deliberately not fixed to #completed here. The ELZ (primary care) use case documents status as always 'completed' (referral is done when sent), but other use cases may use different values. Status is the responsibility of the use case layer.
//
// category: the ELZ profile defines a messageType slice on category with a primary-care- specific OID coding. That slice is not carried here; each use case adds its own category/messageType slice in its own use case layer.
* intent = #order
* subject only Reference(Patient or Group or Location or Device or $nlcore-Patient)
* requester only Reference(Practitioner or PractitionerRole or Organization or Patient or RelatedPerson or Device or $nlcore-PractitionerRole or $nlcore-Organization or $nlcore-Patient or $nlcore-ContactPerson)
* requester insert PartyReferenceComment
* performer only Reference(Practitioner or PractitionerRole or Organization or CareTeam or HealthcareService or Patient or Device or RelatedPerson or $nlcore-PractitionerRole or $nlcore-Organization or $nlcore-Patient or $nlcore-ContactPerson)
* performer insert PartyReferenceComment
* supportingInfo only Reference(Resource or HgReferralComposition or HgReferralDocumentReference)

Profile: HgReferralComposition
Parent: Composition
Id: hg-ReferralComposition
Title: "hg referral Composition"
Description: "Generic transfer summary note carrying the textual *rubrieken* as Composition sections. Open-world base for the use case layer."
// Document type (Composition.type) is intentionally NOT fixed here - it is use case specific. Each use case layer fixes it.
//
// Section structure: deliberately left open at this layer. Experience from the ELZ (primary care) profiles shows that section codes and content are highly use case specific - the ELZ profile defines an Envelope/Core section hierarchy with sections such as CarePath, RequiredConsultationFacilities, MessageReason, SetTreatment, ProposedProcedure, and FurtherImportant, none of which apply directly to the ambulance use case. Each use case layer defines its own section slicing (discriminator and named slices) with the codes appropriate for that transaction; the slicing is intentionally NOT declared here so the use case profile owns it and its snapshot anchors the slice children correctly.
* subject only Reference(Resource or $nlcore-Patient)
* author only Reference(Practitioner or PractitionerRole or Device or Patient or RelatedPerson or Organization or $nlcore-PractitionerRole or $nlcore-Organization or $nlcore-Patient or $nlcore-ContactPerson)
* author insert PartyReferenceComment

Profile: HgReferralDocumentReference
Parent: DocumentReference
Id: hg-ReferralDocumentReference
Title: "hg referral DocumentReference"
Description: "Generic attached document for a referral (for example an ECG or photo). Open-world base for the use case layer."
* subject only Reference(Patient or Practitioner or Group or Device or $nlcore-Patient)
* author only Reference(Practitioner or PractitionerRole or Organization or Device or Patient or RelatedPerson or $nlcore-PractitionerRole or $nlcore-Organization or $nlcore-Patient or $nlcore-ContactPerson)
* author insert PartyReferenceComment
// Document identity is not use case specific - it follows the shared ART-DECOR dataset's CDA externalDocument model, so the structure is defined here at the generic layer (each use case only sets the cardinalities). A CDA externalDocument carries a document instance id (.id, DocumentIdentificatie) and a version-independent set id (.setId, DocumentSetIdentificatie); both are folded onto DocumentReference.identifier and told apart by a local type code, and the version number (versionNumber, DocumentVersienummer) rides the HgExtDocumentVersion extension. This also future-proofs R5/R6, where masterIdentifier is removed (folded into identifier) and version becomes a native element. Cardinalities and obligations are added by the use case layer.
* identifier ^slicing.discriminator[0].type = #pattern
  * ^slicing.discriminator[0].path = "type"
  * ^slicing.rules = #open
* identifier contains documentId 0..* and documentSetId 0..*
* identifier[documentId].type = HgDocumentIdentifierType#document-id
* identifier[documentSetId].type = HgDocumentIdentifierType#document-set-id
* extension contains HgExtDocumentVersion named documentVersion 0..*

Profile: HgReferralMessageHeader
Parent: MessageHeader
Id: hg-ReferralMessageHeader
Title: "hg referral MessageHeader"
Description: "Generic MessageHeader for a referral PUSH. Focuses the referral ServiceRequest; the event is bound to the referral transactions and fixed to one at the use case layer."
* event[x] only Coding
// The event is one of the ART-DECOR referral transactions (hg-message-event); the use case fixes its specific transaction code.
* eventCoding from HgMessageEvents (required)
* focus only Reference(HgReferralServiceRequest)
* sender only Reference(Practitioner or PractitionerRole or Organization or $nlcore-PractitionerRole or $nlcore-Organization)
* sender insert PartyReferenceComment

Profile: HgReferralBundle
Parent: Bundle
Id: hg-ReferralBundle
Title: "hg referral Bundle"
Description: "Generic message bundle for a referral PUSH. The first entry SHALL be the MessageHeader."
* type = #message

// =============================================================================
// hg-ReferralTask (not yet defined)
//
// The ELZ (primary care) profile set includes an hg-ReferralTask profile that links a Task to the ServiceRequest via Task.focus. A generic hg-ReferralTask will be added here when a use case requires explicit workflow tracking (acceptance, status updates, delegation). See the Workflow page for the design rationale.
// =============================================================================
