// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// CapabilityStatements for the Acute Zorg referral exchange.
//
// These are paradigm-neutral REQUIREMENTS-level statements describing what the sending and receiving systems must be capable of. They will be refined once the exchange paradigm (Messaging, REST, or Document) is chosen. Until then the rest.resource block is intentionally omitted; the exchange operations are described on the Data Exchange page.
// =============================================================================

Instance: hg-CapabilityStatement-Sender
InstanceOf: CapabilityStatement
Usage: #definition
Title: "hg referral Sender Capability Statement"
Description: "Requirements on the sending system (ambulance/Regionale Ambulancevoorziening) for the Acute Zorg referral push. The sender produces and transmits the referral. The specific exchange paradigm (FHIR Messaging, RESTful, or FHIR Document) is not yet determined; this statement will be updated once chosen."
* url = "http://nictiz.nl/fhir/CapabilityStatement/hg-CapabilityStatement-Sender"
* name = "HgCapabilityStatementSender"
* status = #draft
* experimental = true
* date = "2026-06-11"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+json
* format[+] = #application/fhir+xml
* implementationGuide = "http://nictiz.nl/fhir/ImplementationGuide/nictiz.fhir.nl.r4.acutezorg"
* purpose = "Informative in nature; it does not represent minimum or maximum capabilities. The exchange paradigm has not yet been chosen (see the Data Exchange page); consult this Implementation Guide for the exact capability requirements."
* copyright = "Copyright and related rights waived via CC0, https://creativecommons.org/publicdomain/zero/1.0/."
* rest[+]
  * mode = #client
  * documentation = "PROVISIONAL: the exchange paradigm (FHIR Messaging, RESTful, or FHIR Document) has not yet been decided (see the Data Exchange page). The `rest` block below is illustrative of the resources and profiles the sending system must be able to produce; the binding interaction model will be fixed once a paradigm is chosen. The sending system produces a conformant referral and transmits it to the receiver. Required resources: ServiceRequest (hg-ReferralServiceRequest-AmbulanceHAP), Composition (hg-ReferralComposition-AmbulanceHAP), DocumentReference (hg-ReferralDocumentReference-AmbulanceHAP, when applicable), Patient (hg-Patient-AmbulanceHAP), Organization (hg-HealthcareProvider-Organization-AmbulanceHAP), PractitionerRole (hg-HealthProfessional-PractitionerRole-AmbulanceHAP), Practitioner (nl-core-HealthProfessional-Practitioner). Under FHIR Messaging: additionally MessageHeader (hg-ReferralMessageHeader-AmbulanceHAP) and Bundle (hg-ReferralBundle-AmbulanceHAP)."
  * resource[+]
    * type = #ServiceRequest
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Composition
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralComposition-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #DocumentReference
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralDocumentReference-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Patient
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-Patient-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Organization
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #PractitionerRole
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthProfessional-PractitionerRole-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Practitioner
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
    * interaction[+].code = #create

Instance: hg-CapabilityStatement-Receiver
InstanceOf: CapabilityStatement
Usage: #definition
Title: "hg referral Receiver Capability Statement"
Description: "Requirements on the receiving system (GP out-of-hours post, HAP) for the Acute Zorg referral push. The receiver accepts and processes the referral. The specific exchange paradigm (FHIR Messaging, RESTful, or FHIR Document) is not yet determined; this statement will be updated once chosen."
* url = "http://nictiz.nl/fhir/CapabilityStatement/hg-CapabilityStatement-Receiver"
* name = "HgCapabilityStatementReceiver"
* status = #draft
* experimental = true
* date = "2026-06-11"
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #application/fhir+json
* format[+] = #application/fhir+xml
* implementationGuide = "http://nictiz.nl/fhir/ImplementationGuide/nictiz.fhir.nl.r4.acutezorg"
* purpose = "Informative in nature; it does not represent minimum or maximum capabilities. The exchange paradigm has not yet been chosen (see the Data Exchange page); consult this Implementation Guide for the exact capability requirements."
* copyright = "Copyright and related rights waived via CC0, https://creativecommons.org/publicdomain/zero/1.0/."
* rest[+]
  * mode = #server
  * documentation = "PROVISIONAL: the exchange paradigm (FHIR Messaging, RESTful, or FHIR Document) has not yet been decided (see the Data Exchange page). The `rest` block below is illustrative of the resources and profiles the receiving system must be able to accept; the binding interaction model will be fixed once a paradigm is chosen. The receiving system accepts a conformant referral and must not raise an error on any obligation-marked element (SHALL:no-error). Required resource types: ServiceRequest, Composition, DocumentReference, Patient, Organization, PractitionerRole, Practitioner. Under FHIR Messaging: additionally supports the $process-message operation on Bundle. Under RESTful: supports create interactions and transaction bundles on the relevant resource types."
  * resource[+]
    * type = #ServiceRequest
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralServiceRequest-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Composition
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralComposition-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #DocumentReference
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-ReferralDocumentReference-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Patient
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-Patient-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Organization
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthcareProvider-Organization-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #PractitionerRole
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/hg-HealthProfessional-PractitionerRole-AmbulanceHAP"
    * interaction[+].code = #create
  * resource[+]
    * type = #Practitioner
    * supportedProfile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
    * interaction[+].code = #create
