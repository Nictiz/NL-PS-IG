# input/resources

Predefined FHIR resources that are not authored in FSH but embedded verbatim, picked up automatically by Sushi / the IG Publisher.

## ART-DECOR terminology (do not hand-edit)

These are FHIR exports downloaded from ART-DECOR (the source of truth). Do not edit them by hand; refresh them from ART-DECOR with the Nictiz download tooling (<https://github.com/Nictiz/Nictiz-R4-zib2020/tree/main/util/downloadTerminology>).

| File | Resource | Canonical |
|---|---|---|
| `2.16.840.1.113883.2.4.3.11.60.55.5.16.xml` | CodeSystem `acutezorg-codesysteem-16` | `urn:oid:2.16.840.1.113883.2.4.3.11.60.55.5.16` |
| `2.16.840.1.113883.2.4.3.11.60.103.11.31--20250820144948.xml` | ValueSet `Bijlagen` | `http://decor.nictiz.nl/fhir/ValueSet/2.16.840.1.113883.2.4.3.11.60.103.11.31--20250820144948` |

The *Bijlagen* value set is bound (required) on `DocumentReference.type` in `hg-ReferralDocumentReference-AmbulanceHAP`. The code system is a `content = not-present` shell; the concepts are enumerated in the value set's `compose.include`. Both keep their source canonicals, which are registered as `special-url` in `sushi-config.yaml`.
