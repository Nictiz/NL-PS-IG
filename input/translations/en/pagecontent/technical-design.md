#### Introduction

This design describes the data exchange mechanisms used by the NL-PS. The functional scope and allocation of responsibilities are defined in the [functional design][fo]. Requirements for identification, authorization, and addressing are determined by the infrastructure used.

##### Parent specifications

The NL-PS also conforms to the [EPS][eps] specifications, which in turn conform to the [IPS][ips] specifications. This conformance is declared using the ["complies with profile"][complies] extension.

#### Transactions

##### Retrieving and providing the NL-PS

###### FHIR query specification

The NL-PS is retrieved using the FHIR `$summary` operation; see the [IPS operation definition][summary]. The operation supports GET and POST; the examples use GET. The response is a `Bundle` with `type=document`. See also the [FHIR document specification][fhirdoc].
Request using a patient-specific bearer token and the corresponding logical Patient ID:

```http
GET [base]/Patient/[id]/$summary?profile=http://ig.nictiz.nl/nlps/StructureDefinition/nl-PatientSummary
Authorization: Bearer [token]
Accept: application/fhir+json or fhir+xml
```

For both options, the NL-PS profile is explicitly requested using the `profile` parameter. This parameter is optional in the IPS operation definition; the server must support the requested NL-PS profile.

###### Patient identification

There are two options for patient identification. Both are subject to the access policies of the infrastructure used.

1. **Bearer tokens.** The patient context is established using a patient-specific bearer token. The association between the token and the patient is determined by the infrastructure agreements. The client sends the token in the HTTP header `Authorization: Bearer [token]`, as specified in [RFC 6750][bearer]. The `[id]` in the request below must match the patient context of the token.
2. **Patient identifiers from an internal system.** The client supplies the patient identifier from the internal system using the `identifier` operation parameter, including the identifier system and value (`[system]%7C[value]` in the URL). This option requires server support. The server maps the identifier to the patient in its own system.

[fo]: https://ig.nictiz.nl/nlps/nl/functional-design.html
[eps]: https://build.fhir.org/ig/hl7-eu/eps/en/index.html
[ips]: https://build.fhir.org/ig/HL7/fhir-ips/en/index.html
[complies]: https://build.fhir.org/ig/HL7/fhir-extensions/en/StructureDefinition-structuredefinition-compliesWithProfile.html
[fhirdoc]: https://hl7.org/fhir/R4/documents.html
[profiel]: https://ig.nictiz.nl/nlps/nl/StructureDefinition-nl-PatientSummary.html
[gbb]: https://ig.nictiz.nl/gbb/nl/
[documenten]: https://hl7.org/fhir/R4/documents.html
[summary]: https://build.fhir.org/ig/HL7/fhir-ips/en/OperationDefinition-summary.html
[bearer]: https://www.rfc-editor.org/rfc/rfc6750.html
