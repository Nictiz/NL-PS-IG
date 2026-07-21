This page lists the example messages provided for review and testing, and gives a functional mapping from the dataset concepts to the FHIR elements they land on.

### How these examples were produced

The example messages are derived from the functional test scenarios maintained in ART-DECOR (the ADA test instances) and from the *Richtlijn Gegevensuitwisseling Acute Zorg*. Nictiz normally generates FHIR instances from ADA test data with the ADA-to-FHIR tooling. That tooling is not yet available for this transaction, so the examples here are a hand-authored interpretation of the ADA instances rather than a tool-generated conversion. They are provisional and should be regenerated and reconciled once ADA-to-FHIR support is in place. Where the ART-DECOR test data leaves an element empty that this IG's profiles make mandatory (for example an organization name, or a URA value), a test value has been filled in; this reflects an ART-DECOR-to-FHIR cardinality mismatch that is itself an open item (see the [Open Items](open-items.html) page).

All example resources use fictional test data only.

### Example scenarios

| Example | Source | What it shows | Message |
|---|---|---|---|
| Scenario 5b | *Richtlijn Gegevensuitwisseling Acute Zorg* | A worked ambulance-to-HAP referral after on-scene care, with an ECG attachment. | [Bundle](Bundle-hg-ReferralBundle-AmbulanceHAP-referral.html) |
| Maximal | ART-DECOR ADA test `az-ave-tst-2-maximaal` | A richly populated message: structured patient with address, telecom and a contact person; a sending nurse; all four Composition sections; and a document attachment. | [Bundle](Bundle-hg-ReferralBundle-AmbulanceHAP-max.html) |
| Minimal | ART-DECOR ADA test `az-ave-tst-3-minimaalTestdag` | A lean message: a patient known by name and gender only, organizations addressed by URA, a free-text reason and the report attachment. | [Bundle](Bundle-hg-ReferralBundle-AmbulanceHAP-min.html) |

### Functional mapping

How the dataset concepts (as seen in the ART-DECOR data set and the ADA scenarios) map to FHIR in this IG. The authoritative, element-level mappings to the `hg-dataelement-NNNN` identifiers are on the Mappings tab of each profile; the table below is a functional summary to help read the examples.

#### Envelope - `ServiceRequest` (and the message wrappers)

| Dataset concept (*Envelop*) | FHIR element |
|---|---|
| Patient | `ServiceRequest.subject` -> `Patient` |
| Verzender - *zorgverlener* | `ServiceRequest.requester` -> `PractitionerRole` -> `Practitioner` |
| Verzender - *zorgaanbieder* | `MessageHeader.sender` -> `Organization`; also `Composition.author` |
| Ontvanger - *zorgaanbieder* | `ServiceRequest.performer` -> `Organization` |
| Bestemmingsstatus | `ServiceRequest.status` |
| Datum en tijd | `ServiceRequest.authoredOn` |
| RedenBericht (reason, free text) | `ServiceRequest.reasonCode.text` |
| AfgesprokenMetPatient | `ServiceRequest.patientInstruction` |
| Kern (link to the core) | `ServiceRequest.supportingInfo` -> `Composition` / `DocumentReference` |
| Message type and event | `MessageHeader.eventCoding`; `Bundle.type = message` |

#### Core - `Composition`

| Dataset concept (*Kern*) | FHIR element |
|---|---|
| RedenBericht | `Composition.section[messageReason]` |
| IngesteldeBehandeling | `Composition.section[treatmentGiven]` |
| Diagnose/Conclusie | `Composition.section[diagnosisConclusion]` |
| AfgesprokenMetPatient | `Composition.section[agreedWithPatient]` |

#### Patient details

| Dataset concept | FHIR element |
|---|---|
| Naamgegevens | `Patient.name` |
| Geslacht | `Patient.gender` |
| Geboortedatum | `Patient.birthDate` |
| Identificatienummer (BSN) | `Patient.identifier` |
| Adresgegevens | `Patient.address` |
| Contactgegevens (telefoon, e-mail) | `Patient.telecom` |
| Contactpersoon | `Patient.contact` |

#### Document - `DocumentReference` (folded *CommunicatieItem*)

| Dataset concept (*Dossier*) | FHIR element |
|---|---|
| Document | `DocumentReference` |
| DocumentIdentificatie | `DocumentReference.identifier[documentId]` |
| DocumentSetIdentificatie | `DocumentReference.identifier[documentSetId]` |
| DocumentVersienummer | `DocumentReference.extension[documentVersion]` |
| DocumentType | `DocumentReference.type` |
| DocumentBestandtype | `DocumentReference.content.attachment.contentType` |
| DocumentInhoud | `DocumentReference.content.attachment.data` |
| DocumentNaam | `DocumentReference.content.attachment.title` |
