### Overview

This page describes the data model for the Ambulanceverwijzing (AMB naar HAP) referral: the resources, how they fit together, the profiles that constrain them, and how to declare conformance and validate. For element-by-element detail, open each profile under [Artifacts](artifacts.html).

### Message structure

A referral always carries the same clinical core, regardless of the exchange paradigm (see [Data Exchange](data-exchange.html)):

- *hg-ReferralServiceRequest-AmbulanceHAP* is the focal resource. It references the patient (*subject*), the sending ambulance (*requester*) and the receiving HAP (*performer*), and carries the clinical content through `supportingInfo`.
- *supportingInfo* points to a *hg-ReferralComposition-AmbulanceHAP* for the transfer summary note (reason, instituted treatment, diagnosis or conclusion) and, when documents are attached, to one or more *hg-ReferralDocumentReference-AmbulanceHAP* resources.
- The dataset's CommunicationItem wrapper is folded into *DocumentReference* (its category on *category*, its sender on *author*); the recipient is the *performer* of the referral.

Under the FHIR Messaging paradigm, two wrapper resources are added on top of this core: *hg-ReferralMessageHeader-AmbulanceHAP* (which identifies the event and focuses the ServiceRequest) and *hg-ReferralBundle-AmbulanceHAP* (the message bundle). Under the RESTful or FHIR Document paradigms these wrappers are replaced by a transaction bundle or a document bundle respectively.

Example messages under [Artifacts](artifacts.html) illustrate the model: a referral based on scenario 5b of the *Richtlijn Gegevensuitwisseling Acute Zorg*; a maximal message modelled on the ART-DECOR ADA test scenario, showing all participating resources and a document attachment; and a minimal message modelled on the ART-DECOR ADA minimal test scenario.

### Profiles in this use case

| Resource | Use case profile | Derived from | Role in the referral |
|---|---|---|---|
| ServiceRequest | [`hg-ReferralServiceRequest-AmbulanceHAP`](StructureDefinition-hg-ReferralServiceRequest-AmbulanceHAP.html) | [`hg-ReferralServiceRequest`](StructureDefinition-hg-ReferralServiceRequest.html) | Focal resource: the referral request |
| Composition | [`hg-ReferralComposition-AmbulanceHAP`](StructureDefinition-hg-ReferralComposition-AmbulanceHAP.html) | [`hg-ReferralComposition`](StructureDefinition-hg-ReferralComposition.html) | Transfer summary note (treatment given, diagnosis/conclusion) |
| DocumentReference | [`hg-ReferralDocumentReference-AmbulanceHAP`](StructureDefinition-hg-ReferralDocumentReference-AmbulanceHAP.html) | [`hg-ReferralDocumentReference`](StructureDefinition-hg-ReferralDocumentReference.html) | Attached document(s), e.g. a report (0..\*) |
| Patient | [`hg-Patient-AmbulanceHAP`](StructureDefinition-hg-Patient-AmbulanceHAP.html) | [`nl-core-Patient`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-Patient) | The patient being referred |
| Organization | [`hg-HealthcareProvider-Organization-AmbulanceHAP`](StructureDefinition-hg-HealthcareProvider-Organization-AmbulanceHAP.html) | [`nl-core-HealthcareProvider-Organization`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-HealthcareProvider-Organization) | Sending (RAV) and receiving (HAP) organizations |
| PractitionerRole | [`hg-HealthProfessional-PractitionerRole-AmbulanceHAP`](StructureDefinition-hg-HealthProfessional-PractitionerRole-AmbulanceHAP.html) | [`nl-core-HealthProfessional-PractitionerRole`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-HealthProfessional-PractitionerRole) | Role of the sending ambulance professional |
| Practitioner | (none - nl-core directly) | [`nl-core-HealthProfessional-Practitioner`](https://simplifier.net/resolve?fhirVersion=r4&canonical=http%3A%2F%2Fnictiz.nl%2Ffhir%2FStructureDefinition%2Fnl-core-HealthProfessional-Practitioner) | The ambulance professional |
| MessageHeader | [`hg-ReferralMessageHeader-AmbulanceHAP`](StructureDefinition-hg-ReferralMessageHeader-AmbulanceHAP.html) | [`hg-ReferralMessageHeader`](StructureDefinition-hg-ReferralMessageHeader.html) | Messaging wrapper: event and focus |
| Bundle | [`hg-ReferralBundle-AmbulanceHAP`](StructureDefinition-hg-ReferralBundle-AmbulanceHAP.html) | [`hg-ReferralBundle`](StructureDefinition-hg-ReferralBundle.html) | Messaging wrapper: the message bundle |

 The free text of each *Composition* section is carried in the section's own narrative (*Composition.section.text*, whose *.div* holds plain text or the limited xhtml allowed for a Narrative).

### Reading obligations

This IG uses the FHIR Obligations framework instead of `mustSupport`. Each obligation-marked element carries two actor-scoped expectations:

- Sender (*hg-ActorSender-AmbulanceHAP*): for a mandatory element (min >= 1) it **SHALL** always populate it (`SHALL:populate`); for an optional element it **SHALL** populate it when it knows a value (`SHALL:populate-if-known`).
- Receiver (*hg-ActorReceiver-AmbulanceHAP*): **SHALL** accept the element without raising an error (`SHALL:no-error`).

Obligations are shown per element on each profile's page. The rationale for this approach is on the [Design Decisions](design-decisions.html#conformance-via-obligations) page.

### Declaring conformance and validating

- Validation. Validate instances with the official HL7 FHIR validator against the package `nictiz.fhir.nl.r4.acutezorg` together with its dependencies (nl-core, zib2020). A resource is conformant when it passes validation against the relevant profile.
- Declaring conformance. In exchange, the nl-core profiles remain the normative basis. A sender that meets the tighter use case cardinalities **MAY** declare this by listing the use case profile canonical in *meta.profile*; a resource that conforms to a use case profile also satisfies nl-core.
- Actor perspective. Validate from the relevant actor's perspective: a sending system against the Sender obligations, a receiving system against the Receiver obligations. Wrapper resources (`MessageHeader`, `Bundle`) are only required under the FHIR Messaging paradigm.

### Dutch-English element name mapping

The ART-DECOR dataset is Dutch-only. Each profile element carries three language-related descriptors sourced differently:

- `alias` carries the Dutch dataset element name verbatim from ART-DECOR, preserving direct traceability to the source.
- `definition` carries the Dutch *omschrijving* from ART-DECOR.
- `short` carries an English translation authored in this IG. Where an equivalent element exists in the ELZ FHIR profiles (`nictiz.fhir.nl.r4.elz`), the same English term is used; elements specific to the AMB-HAP transaction are translated independently.

The Dutch-to-English correspondence per element is therefore visible directly on each profile: the `alias` (Dutch dataset name) and the `short` (English term) are shown for every element on the profile pages under [Artifacts](artifacts.html).
