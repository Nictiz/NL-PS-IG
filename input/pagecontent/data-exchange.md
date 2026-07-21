### Overview

This page currently covers the data exchange architecture for the Ambulanceverwijzing (AMB to HAP) use case. As additional use cases are added to this IG, their exchange architecture will be described here or on separate pages. See [Use cases](use-cases.html) for an overview of all use cases and their status.

The exchange is one-directional (PUSH): the sending system produces and transmits a referral; the receiving system accepts and processes it.

The specific exchange paradigm - how the FHIR resources are packaged and transmitted - has not yet been decided. Three options are being considered and are described below. The profiles in this IG are designed to remain valid under any of the three options; the choice of paradigm determines which wrapper resources (Bundle, MessageHeader) are required and how the HTTP interaction is structured.

### System context and broker

In practice, ambulance/RAV systems do not produce native FHIR resources. A broker component - operated separately from both the RAV and the HAP - converts the native message format (e.g. an HL7 v2 or proprietary format) to FHIR and forwards it to the receiver. This broker is transparent from a conformance perspective: this IG defines what the FHIR content must look like and what the receiving system must be able to accept, regardless of whether the FHIR content was produced directly by the sending system or by an intermediary. The broker is not a formal actor in this IG.

---

### Option 1: FHIR Messaging

The referral is wrapped in a `Bundle` of `type` `message`. The first entry is a `MessageHeader` that identifies the event and references the `ServiceRequest` via `focus`. All referenced resources are included in the same Bundle. The sender transmits the Bundle to the receiver's `$process-message` endpoint or via a store-and-forward intermediary.

Profiles used: the use case Bundle and MessageHeader profiles (`hg-ReferralBundle-*` and `hg-ReferralMessageHeader-*`), and the use case profiles for the enclosed resources.

Fits well when: the infrastructure is event-driven or store-and-forward; the receiver does not expose a FHIR REST endpoint; the transaction must be atomic and self-contained.

Limitations: requires the sender to produce a complete, valid Bundle at the moment of transmission; less suited for incremental updates or queries.

---

### Option 2: RESTful (FHIR REST API)

The sender POSTs resources to the receiver's FHIR server using a transaction Bundle. The `ServiceRequest` is the focal resource; `Composition`, `DocumentReference`, `Patient`, `Organization`, and `PractitionerRole` are included in the same `transaction`. The receiver exposes a FHIR server.

Profiles used: the use case profiles for all individual resources; no MessageHeader or message Bundle required.

Fits well when: the receiver already hosts a FHIR server; query and update patterns are needed alongside the initial push; integration with standard FHIR tooling is a priority.

Limitations: requires the receiver to expose and maintain a FHIR REST API; managing referential integrity across separate POSTs requires a transaction Bundle or careful ordering.

---

### Option 3: FHIR Document

The referral is wrapped in a `Bundle` of `type` document. The first entry is a `Composition` that organises the clinical content. The Bundle is an immutable, attestable clinical document that can be stored and exchanged as a unit.

Profiles used: the use case Composition profile as the document anchor; a document Bundle (not a messaging Bundle); the use case profiles for the enclosed resources.

Fits well when: the referral needs to be stored as a legal or attestable document; integration with document-sharing infrastructure (IHE XDS/MHD) is required.

Limitations: a document Bundle is immutable - corrections require a new document; less suited for workflow tracking or status updates.

---

### Decision status

The exchange paradigm has not yet been selected. The decision will be driven by the target infrastructure and by alignment with other Acute Zorg use cases in this IG. This page will be updated once a paradigm is chosen.

The CapabilityStatements (`hg-CapabilityStatement-Sender` and `hg-CapabilityStatement-Receiver`) currently reflect paradigm-neutral requirements and will be refined once the paradigm is fixed.

Likewise, the concrete transaction definitions a reader may expect from other Nictiz FHIR IGs - the search parameters, the request/response message structure, and the per-transaction profile lists - are added once the paradigm is chosen (see the [Open Items](open-items.html) page).

---

### Sender requirements

The formal sender requirements are defined in:

- [hg referral Sender - Ambulanceverwijzing (AMBS, AZP-AVS)](ActorDefinition-hg-ActorSender-AmbulanceHAP.html)
- [hg referral Sender CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Sender.html)

In summary, regardless of paradigm, the sender **SHALL**:

- Produce a conformant use case ServiceRequest as the focal resource
- Populate every mandatory obligation-marked element (`SHALL:populate`) and every optional one it has a value for (`SHALL:populate-if-known`)
- Produce a conformant use case Composition carrying the transfer summary note sections
- Attach supporting documents as use case DocumentReference instances when available
- Populate patient, organization, and professional resources conformant to the use case profiles

Under Option 1 (Messaging): additionally produce use case Bundle and MessageHeader resources, and transmit the Bundle to the receiver's endpoint.

Under Option 2 (REST): additionally POST resources to the receiver's FHIR server using a transaction Bundle to ensure atomicity.

Under Option 3 (Document): additionally produce a document Bundle with the use case Composition as the first entry.

---

### Receiver requirements

The formal receiver requirements are defined in:

- [hg referral Receiver - Ambulanceverwijzing (HIS/HAPIS, AZP-AVO)](ActorDefinition-hg-ActorReceiver-AmbulanceHAP.html)
- [hg referral Receiver CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Receiver.html)

In summary, the receiver **SHALL**:

- Accept and process a referral push without raising an error on any obligation-marked element (`SHALL:no-error`)
- Store or route the referral for clinical review
- Handle all resource types included in the referral: `ServiceRequest`, `Composition`, `DocumentReference`, `Patient`, `Organization`, `PractitionerRole`, `Practitioner`

Under Option 1 (Messaging): additionally expose a `$process-message` endpoint or receive messages via an intermediary; process the Bundle of `type` `message`.

Under Option 2 (REST): additionally expose a FHIR REST server supporting at minimum `create` interactions on the relevant resource types, and support transaction Bundles.

Under Option 3 (Document): additionally accept a Bundle of `type` document and store or index it via the applicable document-sharing infrastructure.