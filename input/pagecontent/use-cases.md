### Overview

This IG covers referral transactions from the [Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022)](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf). Each use case maps to a specific message in the *richtlijn* and is implemented as a separate use case layer on top of the generic `hg-Referral*` profiles.

| Use case | Message | Status |
|---|---|---|
| [Ambulanceverwijzing naar HAP](#ambulanceverwijzing-naar-hap-amb-naar-hap) (AMB naar HAP) | Message 24 | Included in this version |
| [Ambulanceverwijzing naar HA](#ambulanceverwijzing-naar-ha-amb-naar-ha) (AMB naar HA) | Message 23 | Planned |

---

### Ambulanceverwijzing naar HAP (AMB naar HAP)

Handover of a patient by an ambulance professional to a GP out-of-hours post (HAP, *huisartsenpost*) after on-scene care. The exchange is one-directional (PUSH): the ambulance/regionale ambulancevoorziening (RAV) sends, the HAP receives.

Functional design: [Section 2.16 of the Nictiz functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29) - see also the [Functional Design](functional-design.html) page in this IG.

Actors:

- [hg referral Sender - Ambulanceverwijzing (AMBS, AZP-AVS)](ActorDefinition-hg-ActorSender-AmbulanceHAP.html)
- [hg referral Receiver - Ambulanceverwijzing (HIS/HAPIS, AZP-AVO)](ActorDefinition-hg-ActorReceiver-AmbulanceHAP.html)

CapabilityStatements:

- [hg referral Sender CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Sender.html)
- [hg referral Receiver CapabilityStatement](CapabilityStatement-hg-CapabilityStatement-Receiver.html)

Profiles: see [Artifacts](artifacts.html#structures-resource-profiles) for the full list of `hg-Referral*-AmbulanceHAP` profiles, and the [Data Model](data-model.html) page for the message structure, profile table, and conformance guidance.

Examples under [Artifacts](artifacts.html): a worked referral based on scenario 5b of the *Richtlijn Gegevensuitwisseling Acute Zorg*; a maximal message modeled on the ART-DECOR test scenario (a richly populated patient and message, with a document attachment); and a minimal message modelled on the ART-DECOR  minimal test scenario.

Data exchange: see [Data exchange](data-exchange.html) for the exchange paradigm options and sender/receiver requirements for this use case.

---

### Ambulanceverwijzing naar HA (AMB naar HA)

Handover of a patient by an ambulance professional to a GP (HA, *huisarts*). Follows the same pattern as AMB naar HAP; will add a parallel `hg-Referral*-AmbulanceHA` use case layer and a new message event code. Not yet defined in this version.
