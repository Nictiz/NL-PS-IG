This page documents the key modeling and conformance choices made in this IG, and the rationale behind them.

### Conformance to the Nictiz FHIR R4 IG

This IG follows the overarching principles of the [Nictiz FHIR R4 Implementation Guide](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4) - the baseline all Nictiz FHIR R4 information standards conform to - together with the [FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4). The layered profiling (§2.1), the profiling guidelines (§2.2), coded concepts carrying a Dutch `display` (§2.4), references kept resolvable with `.type`/`.display` and the target profile beside the core type (§2.5), `meta.profile` declared with both the use case and the nl-core canonical for nl-core-derived resources (§2.6), and the SNOMED CT Netherlands edition pinned for validation (§2.12) are all applied as that IG prescribes. That IG allows an information standard to "extend, specialize or overrule" its principles where this is *explicitly documented*; the points below are this IG's documented choices.

Deviation - obligations instead of `mustSupport`. Where the core IG expects use case profiles to apply `mustSupport`, this IG expresses support expectations with the FHIR Obligations framework instead (see [Conformance via obligations](#conformance-via-obligations)). Obligations carry directional, actor-scoped and machine-readable expectations that a single `mustSupport` flag cannot; this is a deliberate substitution, not an omission.

Mandatory vs Required, and missing data (§2.13). The core IG distinguishes the ART-DECOR designations *Mandatory* and *Required*, and asks each standard to state how the Data Absent Reason extension applies. This IG maps the distinction onto its two obligation rule sets: a *Mandatory* element (min >= 1) carries `SHALL:populate`, a *Required* element (min 0) carries `SHALL:populate-if-known`. The Data Absent Reason extension is not used: in this one-directional PUSH an unknown optional element is simply omitted rather than sent with a reason for absence. This can be revisited if a use case needs to assert *why* a required value is absent.

Narrative (§2.14). The free-text *rubrieken* are carried in the relevant `Composition.section.text` (with `text.status = additional`); see [Envelope and core](#envelope-and-core-servicerequest-and-composition). This IG does not additionally require a generated `Resource.text` narrative on each resource - that expectation will be set together with the exchange paradigm.

Deferred pending the exchange paradigm. The core IG's transport-level principles - HTTP headers (§2.3), search (§2.7), error handling and `OperationOutcome` (§2.9), the informative role of CapabilityStatements (§2.10), secondary resources in transactions (§2.11) and `Bundle.entry.fullUrl` conventions (§2.8) - depend on the exchange paradigm, which is not yet chosen (see [Data Exchange](data-exchange.html) and the [Open Items](open-items.html) page). The profiles are designed to remain valid under all candidate paradigms; this guidance is completed once the paradigm is fixed.

### Base profiles

All participating resources build on nl-core (zib2020, R4). Identifiers, name and address structures, and organization and practitioner modeling follow nl-core, which keeps the IG aligned with the wider Dutch FHIR ecosystem.

### Workflow request resource

The referral is modeled as a `ServiceRequest` on FHIR core, with the `intent` element using the pattern `order`. The ambulance is the `requester` and the HAP is the `performer`. This follows the FHIR workflow request pattern.

### Envelope and core: ServiceRequest and Composition

The ART-DECOR data set nests its content in two containers: the *Envelop* (the outer envelope - addressing and triage: destination status, patient, send date/time, sender, recipient) and the *Kern* (the clinical core - reason, instituted treatment, diagnosis/conclusion, agreements with the patient, attachments). This IG splits those over two FHIR resources, each with its root mapped to its primary container: the `ServiceRequest` represents the *Envelop*, and the `Composition` represents the *Kern*.

The two are not watertight, and that is deliberate. The `ServiceRequest` (Envelop) also surfaces a few *Kern* elements - the reason (`reasonCode`), the agreements with the patient (`patientInstruction`) and a reference to the core (`supportingInfo`) - so that the receiving system can triage the referral early, before opening the document. Conversely the `Composition` (Kern) carries some *Envelop* elements - `subject`, `author` and `date` - because a FHIR document must declare its patient, author and date; these reuse the same patient, sender and timestamp the envelope carries.

The `ServiceRequest` values are authoritative and exist for early triage; where the same content is also placed on the `Composition` it is a documentation copy, persisted in the receiving system's record (see the reason and agreed-with-patient sections, which carry that note). Each root is mapped to its own container only - the `Composition` is not separately mapped to *Envelop*, because reusing the envelope's patient and sender does not make the document the envelope. The cross-container elements are traced individually in the [dataset mappings](#dataset-traceability).

### No Task, for now

We deliberately omit `Task` and follow the ad-hoc workflow pattern. See the [Workflow](workflow.html) page for the rationale and a description of how `Task` could be introduced in a future version without reworking the referral content profiles.

### Exchange paradigm

The exchange paradigm has not yet been decided; the profiles are designed to remain valid under all the options under consideration. The [Data Exchange](data-exchange.html) page describes each option and its server and client requirements.

### Terminology

Bindings use zib and nl-core value sets where available.

Some SNOMED CT codes in this IG (for example `11131000146102` on `ServiceRequest.code`) belong to the Netherlands edition (module `11000146104`) rather than the International edition. The build therefore pins the SNOMED edition for validation through an expansion-parameters resource (`expansion-params.json`, referenced from `sushi-config.yaml` via `path-expansion-params`), so the terminology server resolves these codes against the Netherlands edition. When a newer NL edition is adopted, update the version URI in `expansion-params.json`.

Project-specific terminology is not authored in FSH; it is taken straight from ART-DECOR, which is the source of truth. The `DocumentReference.type` binding (the BSA *Bijlagen* list) uses two FHIR exports embedded verbatim as predefined resources in `input/resources`: the `acutezorg-codesysteem-16` code system (`urn:oid:2.16.840.1.113883.2.4.3.11.60.55.5.16`) and the *Bijlagen* value set (`http://decor.nictiz.nl/fhir/ValueSet/2.16.840.1.113883.2.4.3.11.60.103.11.31--20250820144948`). These files are downloaded from ART-DECOR, not edited by hand, and keep their source canonicals (registered as `special-url` in `sushi-config.yaml` so the IG Publisher accepts the non-IG base).

### DocumentReference identifiers (CDA externalDocument)

In the source, an attached document is a CDA `externalDocument` carrying three identity fields: a document instance id (`.id`, DocumentIdentificatie, hg-dataelement-5473), a version-independent set id (`.setId`, DocumentSetIdentificatie, hg-dataelement-5474), and a version number (`versionNumber`, DocumentVersienummer, hg-dataelement-5475).

FHIR R4 `DocumentReference` offered `masterIdentifier` (0..1, the document's master id) alongside `identifier` (0..\*, other ids). R5/R6 removed `masterIdentifier`, folding it into `identifier`. To avoid a breaking remodel when this IG moves to R5/R6, we already adopt the R5/R6 shape now: both the document id and the set id are carried on `identifier`, and `masterIdentifier` is forbidden (`0..0`).

FHIR defines no standard code to distinguish a document instance id from a set id and explicitly leaves disambiguation of multiple identifiers "to the implementation context". We therefore slice `identifier` by `type` using a small local code system ([`acutezorg` document-identifier-type](CodeSystem-hg-document-identifier-type.html): `document-id` / `document-set-id`) - authored in FSH because it is a structural modelling code, not a clinical concept from the dataset. Each CDA `II` maps as `system` = `urn:oid:{II.root}` and `value` = `{II.extension}`.

The version number has no R4 element, so it rides the [`hg-ext-DocumentVersion`](StructureDefinition-hg-ext-DocumentVersion.html) extension; this maps directly to the native `DocumentReference.version` element in R5/R6, after which the extension is retired.

Because this identity model follows the shared dataset's document structure rather than anything use-case specific, the `identifier` slicing structure and the version extension are defined on the generic `hg-ReferralDocumentReference` profile; the use case layer adds the cardinalities (including forbidding `masterIdentifier` with `0..0`) and the obligations. This `type`-code scheme is posted to the FHIR community chat for confirmation and may be revised; see the [Open Items](open-items.html) page.

### Profile layering and naming

Following the [Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4), profiles are organised in two layers. A generic, open-world layer on FHIR core carries the reusable referral structure with no cardinality tightening and no obligations: `hg-ReferralServiceRequest`, `hg-ReferralComposition`, `hg-ReferralDocumentReference`, `hg-ReferralMessageHeader` and `hg-ReferralBundle`. A use case layer derives from these for this transaction and adds cardinalities, obligations (see below), the fixed message event and the dataset mappings: `hg-ReferralServiceRequest-AmbulanceHAP` and its siblings. Names use the `hg-` project prefix with the use case appended; other referral transactions can reuse the generic layer and add their own use case profiles.

Alongside these, three transaction-specific zib profiles carry the dataset's cardinalities on the participating building blocks, each derived from the corresponding nl-core profile: `hg-Patient-AmbulanceHAP` (from nl-core-Patient), `hg-HealthcareProvider-Organization-AmbulanceHAP` (from nl-core-HealthcareProvider-Organization) and `hg-HealthProfessional-PractitionerRole-AmbulanceHAP` (from nl-core-HealthProfessional-PractitionerRole). These hold the minima needed to identify the patient and the sending/receiving organizations and should be reconciled against the published dataset's exact multiplicities.

These transaction-specific profiles are primarily intended for validation, not for constraining data exchange. In exchange, the corresponding nl-core profiles remain the normative basis. Implementers may however declare conformance to the tighter use case profiles via `meta.profile` in the resource if they wish to signal that the stricter cardinalities are met.

Vendors that already support nl-core do not need to rebuild their FHIR infrastructure for this transaction: the use case layer only adds a named validation profile on top of what is already there. Different use cases may still require functional or workflow adaptations beyond the FHIR layer.

### Conformance via obligations

Instead of `mustSupport`, support expectations are expressed with the FHIR Obligations framework. Two system actors are defined per use case as `ActorDefinition` resources: for the Ambulanceverwijzing these are `hg-ActorSender-AmbulanceHAP` (the ambulance/RAV system that produces and pushes the message) and `hg-ActorReceiver-AmbulanceHAP` (the HAP system that consumes it). The reusable `Obligation` rule set references them through aliases, so each use case supplies its own sender and receiver actors. Obligation-marked elements carry, via the `obligation` extension, a Sender obligation and a `SHALL:no-error` obligation for the Receiver (it must accept the element without error). The Sender obligation depends on cardinality: a mandatory element (min >= 1) carries `SHALL:populate` (the Sender must always populate it), while an optional element carries `SHALL:populate-if-known` (the Sender must populate it when it knows a value) - `populate-if-known` would contradict a 1..1/1..* element, which is always required. This makes the producer and consumer expectations explicit and machine-readable, where `mustSupport` would only carry a single, direction-less flag.

### Invariants and constraints

Beyond cardinalities, bindings and slicing, the use case profiles carry a small number of FHIRPath invariants - only for rules that structure cannot express, and kept resource-local so they also hold when a resource is validated standalone:

- `hg-Patient-AmbulanceHAP` obeys `hg-pat-1`: the patient must be matchable at the receiver (an `identifier` or a `name` is present).
- `hg-HealthcareProvider-Organization-AmbulanceHAP` obeys `hg-org-1`: the organization should be unambiguously addressable (a URA `identifier` is present).

Both are `#warning` for now, because a not-yet-identified ambulance patient and addressing other than by URA are legitimate edge cases; they can be raised to `#error` once the ART-DECOR conformance mapping confirms the requirement (see the [Open Items](open-items.html) page).

Two further categories are deliberately *not* enforced as invariants yet. Message-level rules (for example, that the Bundle contains the `ServiceRequest` referenced by `MessageHeader.focus` and the `Composition` it points to) are held until the exchange paradigm is chosen, since they only apply under FHIR Messaging. Cross-resource subject consistency (the `Composition` and `DocumentReference` subject being the same patient as the `ServiceRequest`) and a couple of `DocumentReference` structural tightenings are tracked as open items rather than enforced, to avoid `resolve()`-based invariants that are unreliable in standalone validation and to avoid constraining ahead of the dataset.

### Reference modeling (open world)

References are kept open. Where the dataset binds a reference to an nl-core building block, the transaction-specific zib profile is added *next to* the base FHIR resource type rather than replacing it: for example `ServiceRequest.subject` is `Reference(Patient or hg-Patient-AmbulanceHAP)` and `requester`/`performer` allow `PractitionerRole`/`Organization` next to their hg- profiles. This follows the [Nictiz profiling guideline](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4) of adding the target profile beside the core type, so a sender that holds only a plain core resource still conforms, while a sender that can produce the richer nl-core-based profile is recognized.

[§6.2 of the profiling guideline](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4) recommends slicing a reference by `targetProfile` (`discriminator.type = profile`, `discriminator.path = resolve()`) to attach per-target mappings to the functional model. That mechanism requires the reference to be repeatable (max > 1), because FHIR does not permit slicing an element with max = 1. In this transaction the references that carry a per-target distinction - `ServiceRequest.requester` (Verzender) and `ServiceRequest.performer` (Ontvanger), each mapping to a *zorgverlener* (PractitionerRole) and a *zorgaanbieder* (Organization) dataelement - are constrained to exactly one sender and one recipient (`1..1`), so they cannot be sliced. Their per-target dataelements are therefore recorded as element-level mappings (the *zorgaanbieder* is the Organization reached via the sending PractitionerRole's `.organization`). targetProfile slicing would be the right tool for a future repeatable reference.

The *zorgaanbieder* is referenced as `nl-core-HealthcareProvider-Organization` directly, not through the `nl-core-HealthcareProvider` (Location) focal resource. nl-core makes Location the focal resource of the zib HealthcareProvider because, in its words, "most references to this zib are concerned about the recording of the physical location where the care to patient/client takes place rather than the organizational information." That rationale does not hold here: the *zorgaanbieder* on `requester`/`performer` (and on `MessageHeader.sender`) is the organizational identity of the message sender and recipient (RAV and HAP, addressed by URA), an addressing concept with no care-location component, and the dataset carries no location data to populate a Location resource. Routing through the Location focal resource would add an empty Location whose only content is `managingOrganization`. We therefore reference the Organization profile directly; a use case that genuinely needs the physical care location should reference `nl-core-HealthcareProvider` instead.

#### Why nl-core profiles are listed alongside FHIR core types

When a reference constraint lists only an nl-core profile \- for example `Reference(nl-core-Patient)` \- a FHIR validator requires the referenced resource to conform to that profile, so a plain R4 Patient would fail even when all clinically relevant fields are present. Writing `Reference(Patient or nl-core-Patient)` accepts both, keeping the profile open to senders that do not (yet) produce nl-core-profiled resources.

This applies at both layers. The generic profiles include the base FHIR R4 type alongside every nl-core equivalent (`Patient or nl-core-Patient`, `Practitioner or nl-core-Practitioner`, `PractitionerRole or nl-core-PractitionerRole`, `Organization or nl-core-Organization`) so the generic layer does not impose a Dutch-specific dependency. The use case profiles further add the use case-specific zib profiles beside both core and nl-core types. A resource conforming to a use case-specific profile also satisfies nl-core and by extension FHIR core, so the hierarchy is consistent: stricter profiles are always offered *in addition to* less strict ones, never as sole alternatives.

### Resource map

The resource map - which resources participate, how they reference each other, and which profile constrains each - is on the [Data Model](data-model.html#message-structure) page, together with a profile table and a worked example.

### Dataset traceability

Each use case profile carries `Mapping` entries back to the ART-DECOR dataset *Verwijzing ambulance naar huisartsenpost* (OID 2.16.840.1.113883.2.4.3.11.60.103.1.1), under the identity `hg-dataset-20201019`, following the [Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4). FHIR elements point at the dataset data-element ids (`hg-dataelement-NNNN`).

The `hg-dataelement-NNNN` series comes from the shared ART-DECOR project; the [Dependencies](dependencies.html#relationship-with-the-elz-package) page explains how that project relates to the ELZ package and why the elements carry the `hg-` prefix.

Because the CommunicatieItem wrapper was folded into `DocumentReference`, the DocumentReference root is mapped to both the CommunicatieItem (hg-dataelement-5457) and the Document inside it (hg-dataelement-5472); the document and set ids map to the two `identifier` slices (hg-dataelement-5473 and 5474) and the version number to the [`hg-ext-DocumentVersion`](StructureDefinition-hg-ext-DocumentVersion.html) extension (hg-dataelement-5475). MessageHeader and Bundle are transport resources and map only at envelope level (sender, timestamp). Any remaining unmapped dataset elements are tracked on the [Open Items](open-items.html) page. All mappings should be reviewed against the published dataset version.
