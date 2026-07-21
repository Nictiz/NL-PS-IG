### Overview

This Implementation Guide does not stand alone. It implements an exchange that is specified upstream - by a functional design, an ART-DECOR dataset and the zibs - and it is built technically on a set of FHIR packages (nl-core, zib2020 and the FHIR tooling extensions). This page explains both kinds of dependency: the *specification chain* that defines what is exchanged, and the *FHIR packages* this IG builds on. It also describes how this IG relates to the primary care ELZ package.

### Specification chain (what is exchanged)

Three upstream Nictiz artifacts define the content this IG implements. Each is versioned independently of this IG.

| Artifact | Version | Role | Source |
|---|---|---|---|
| Functioneel ontwerp Acute Zorg | V2.2.0 | Functional design: scenarios, parties and transactions at a functional level | [wiki](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg) |
| ART-DECOR data set + scenario/transaction | Release V1.0.0-alpha.2 (Ambulanceverwijzing naar Huisartsenpost) | Machine-readable data set (data elements, cardinalities, value sets) and the transaction definition | [publication](https://decor.nictiz.nl/pub/eerstelijnszorg/hg-html-20260317T103425/index.html) |
| Zib publication 2020 | 2020 | The clinical building blocks (zibs) the data set and nl-core are built from | [zibs.nl][zib2020] |

The functional design translates the *Richtlijn Gegevensuitwisseling Acute Zorg* into implementable scenarios and transactions. The ART-DECOR publication then formalizes the AMB-HAP transaction into a machine-readable data set: this is where the `hg-dataelement-NNNN` element identifiers, their cardinalities and the project value sets come from, and it is the source of truth for the terminology embedded in this IG. The ART-DECOR publication is still an alpha release and is going to be updated, so element details and cardinalities may still change - the mapping of those cardinalities and conformance onto FHIR is itself an open item (see the [Open Items](open-items.html) page).

The zibs (publication 2020) enter this IG twice over: implicitly through the data set, which is built from zibs, and through nl-core, the FHIR representation of the zibs that this IG's profiles derive from. The zib version is therefore not pinned directly in this IG; it follows from the data set and from the nl-core/zib2020 package versions below.

### FHIR packages (how it is built)

Technically, this IG is a FHIR package that declares the following dependencies. The exact pinned versions are in [`sushi-config.yaml`](https://github.com/Nictiz) and listed in the [README](index.html); the resolved set is:

{% include dependency-table.xhtml %}

- nl-core (`nictiz.fhir.nl.r4.nl-core`) - the FHIR profiles that represent the zibs. This IG's transaction-specific zib profiles (`hg-Patient-AmbulanceHAP` and siblings) derive from nl-core, and every reference targets the nl-core profile beside the bare FHIR type.
- zib2020 (`nictiz.fhir.nl.r4.zib2020`) - the zib layer that nl-core builds on; pulled in transitively.
- elz (`nictiz.fhir.nl.r4.elz`) -is the FHIR implementation of the primary care (Eerstelijnszorg, ELZ)
- FHIR tooling (`hl7.fhir.uv.tools.r4`) - supplies the Obligations and `ActorDefinition` machinery this IG uses for conformance instead of `mustSupport`.

Note that the project-specific terminology (the *Bijlagen* value set and the `acutezorg-codesysteem-16` code system) is not a package dependency: it is downloaded from ART-DECOR and embedded verbatim in `input/resources`. See the [Design Decisions](design-decisions.html) page for why, and the caveats that come with it.

All three Nictiz packages are currently beta releases, so this IG is pre-publication and its dependencies may move as those packages stabilize.

Beyond these packages, this IG conforms to the overarching [Nictiz FHIR R4 Implementation Guide](https://informatiestandaarden.nictiz.nl/wiki/FHIR:V1.0_FHIR_IG_R4) - the baseline principles all Nictiz FHIR R4 standards follow. It is documentation rather than a package dependency; how this IG applies its principles, and the points where it deviates or defers, are set out under [Conformance to the Nictiz FHIR R4 IG](design-decisions.html#conformance-to-the-nictiz-fhir-r4-ig).

### Relationship with the ELZ (package)

This IG and the primary care ELZ package draw on the same ART-DECOR project; the [Dependencies](dependencies.html) page describes that relationship and the overlapping canonical URLs. Although they share the `hg-` profile IDs, the profiles are not the same: the generic layer here was developed independently and intentionally diverges from ELZ in several places:

- `hg-ReferralServiceRequest`: the ELZ profile fixes `status` to *completed* and defines a `category` slice with a primary-care-specific OID coding. Both are omitted here as they are ELZ specific; use case layers in this IG add their own `category` slice and `status` constraints where needed.
- `hg-ReferralComposition`: the ELZ profile defines a detailed Envelope/Core section hierarchy specific to primary care (CarePath, RequiredConsultationFacilities, MessageReason, etc.). Section structure has proven to be use case specific, so no named sections are defined at the generic layer; each use case adds its own section slices.
- `hg-ReferralTask`: present in ELZ. Not yet defined here; will be added when a use case requires explicit workflow tracking.
- `hg-ReferralMessageHeader`, `hg-ReferralBundle`, `hg-ReferralDocumentReference`: present in this IG, not in ELZ.

These differences are not blocking while both packages are in beta, but they must be reconciled before either reaches a stable release (tracked on the [Open items](open-items.html) page).

[`nictiz.fhir.nl.r4.elz`](https://simplifier.net/packages/nictiz.fhir.nl.r4.elz) is the FHIR implementation of the primary care (*Eerstelijnszorg*, ELZ) transactions in the same ART-DECOR project (`hg-`) that this IG uses for the acute care AMB-HAP transaction. That project was originally established for primary care exchanges and has since been widened to cover acute care use cases such as ambulance referrals. Because both packages draw on that one project, they are entangled in two ways:

- Shared data set and identifiers. Both packages take their `hg-dataelement-NNNN` element identifiers and the `hg-` canonical prefix from the same ART-DECOR project, so the same element ids appear in both.
- Overlapping generic profiles. The generic `hg-Referral*` profiles' canonical URLs currently exist in both this package and ELZ. The intended dependency direction is that ELZ depends on Acute Zorg for these shared generic profiles - not the reverse. The generic profiles belong here, as the core of the Acute Zorg umbrella IG, and are not to be moved into ELZ.

This is a governance and reconciliation item rather than a blocker while both packages are in beta. The profile-by-profile divergence from ELZ is described on the [Functional design](functional-design.html) page, and the canonical-URL overlap is tracked on the [Open Items](open-items.html) page.

### How it fits together

The diagram below shows the specification chain feeding this IG (and ELZ), and the FHIR packages this IG builds on. Solid arrows mean "feeds / is built from"; dashed arrows mean "implements / depends on".

<div>{% include dependencies.svg %}</div>
<br clear="all"/>

[zib2020]: https://www.zibs.nl/wiki/ZIB_Publicatie_2020(NL)
