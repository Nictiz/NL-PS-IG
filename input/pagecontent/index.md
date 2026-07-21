### Scope

This Implementation Guide provides [FHIR R4](https://hl7.org/fhir/R4/) profiles and guidance for information exchange in acute care settings in the Netherlands, following the [Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022)](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf) and the [Nictiz functional design for Acute Zorg](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg). All profiles are built on [nl-core](https://simplifier.net/nictiz-r4-zib2020) (zib2020, R4) and follow the [Nictiz FHIR Profiling Guidelines R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4) and the [Nictiz FHIR R4 Implementation Guide](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4).

The IG is organized in two layers. A generic layer defines open-world profiles that are reusable across referral use cases. Use case layers derive from these and add the cardinalities, obligations, terminology bindings and dataset mappings specific to each transaction.

The intended audience of this IG is software developers building sending or receiving systems for acute care information exchange in the Netherlands.

#### Conformance language

The key words **SHALL**, **SHALL NOT**, **SHOULD**, **SHOULD NOT**, and **MAY** in this specification are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

#### Language

This IG is written in English. The underlying functional design and ART-DECOR dataset are in Dutch; Dutch terms appear in the `alias` and `definition` attributes of the different profile elements throughout. A full explanation of the Dutch-English mapping is provided on the [Data model](data-model.html#dutch-english-element-name-mapping) page.

#### Use cases

An overview of all current and planned use cases, including actors, CapabilityStatements, and profile links per use case, is on the [Use cases](use-cases.html) page.

### Design decisions

Key modeling and conformance choices - profile layering, the obligations framework, open-world reference modeling, and dataset traceability - are documented on the [Design decisions](design-decisions.html) page. The table of relevant resources and corresponding profiles are on the [Data model](data-model.html) page.

### Open items

A number of profile decisions and architectural choices are still pending. See the [Open items](open-items.html) page; the full list, including build and tooling tasks, is tracked in the [GitHub issues](https://github.com/Nictiz/AZ-IG/issues).

### Versioning and releases

Versions follow the Nictiz [Nationaal Releasebeleid](https://nationalebibliotheek.nictiz.nl/assets/uploads/2026/03/20260122_Nationaal-releasebeleid-versie-0.9.pdf) (semantic versioning). Concept publications preceding the first release carry a suffix - `0.y.z-alpha` (for consultation), `0.y.z-beta` (feature-complete, for testing in a test setting) or `0.y.z-rc` (release candidate); the first full publication is `1.0.0`. From `1.0.0` onward, incompatible changes increment the major version, compatible functional changes the minor, and compatible fixes the patch. Versions before `1.0.0` - including the current one - are pre-publication and intended for review and testing, not for production use.

The current version number is provisional and was chosen independently. On first publication it will be aligned with the release versions of the upstream ART-DECOR data set and functional design, so the Acute Zorg release is coherent across all three (see the [Open items](open-items.html) page).

The notable changes per version are on the [Changelog](changelog.html) page; the per-version downloadable packages and the full issue-level history are in the [GitHub repository](https://github.com/Nictiz/AZ-IG).

### Dependencies

The [Dependencies](dependencies.html) page lists the FHIR packages this IG depends on and explains how they and the upstream specifications (functional design, ART-DECOR data set, zibs) relate, including the relationship with the primary care ELZ package.

### Building this IG

The profiles are authored in FSH and compiled with Sushi, then built with the HL7 IG Publisher.

### Authors and publication

This Implementation Guide is authored and published by Nictiz, and will be used in a proof of concept (PoC) in the near future.

The contributing authors are:

- Eduard de Rijcke (Nictiz)
- Onno Gieling (Nictiz)
- Shenaida Hoogland (Nictiz)
- Yvette Maes (Nictiz)
- Niek van Galen (Interoplab)

### Authoring note

The authors use AI to help write and structure the narrative pages, the repository documentation, the GitHub issues and the release notes, and to correct grammar - keeping the English from sliding into Dunglish. The explanatory comments in the FSH source are AI-generated for convenience. The authors remain responsible for all content and review everything before publication.

### References

1. Nictiz. *Richtlijn Gegevensuitwisseling Acute Zorg versie 4*. 2022. [PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)
2. Nictiz. *Ontwerp Acute Zorg - Functioneel ontwerp*. [https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg)
3. Nictiz. *Nictiz FHIR Implementation Guide R4*. [https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4)
4. Nictiz. *FHIR Profiling Guidelines R4*. [https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_Profiling_Guidelines_R4)
5. Nictiz. *nl-core FHIR R4 package* (nictiz.fhir.nl.r4.nl-core 0.12.0-beta.4). [https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core](https://simplifier.net/packages/nictiz.fhir.nl.r4.nl-core)
6. Nictiz. *zib2020 FHIR R4 package* (nictiz.fhir.nl.r4.zib2020 0.12.0-beta.4). [https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020](https://simplifier.net/packages/nictiz.fhir.nl.r4.zib2020)
7. HL7. *FHIR Tools R4 package* (hl7.fhir.uv.tools.r4 1.1.2). [https://packages.fhir.org/hl7.fhir.uv.tools.r4/1.1.2](https://packages.fhir.org/hl7.fhir.uv.tools.r4/1.1.2)