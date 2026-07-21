### Background

The information exchange described in this Implementation Guide is defined by two Nictiz documents:

- The Richtlijn Gegevensuitwisseling Acute Zorg versie 4 (2022) ([PDF](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf)) is the policy-level guideline that establishes which data must be exchanged between parties in acute care settings in the Netherlands. It defines the scenarios, parties, and content requirements at a clinical level.

- The Ontwerp Gegevensuitwisseling Acute Zorg ([functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg)) is the Nictiz functional design document that translates the ([richtlijn](https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf))* into structured, implementable information exchange specifications. It defines datasets, message structures, and exchange directions for each use case.

### Position in the Nictiz five-layer model

Interoperability requires agreements on five layers - the Nictiz [vijflagenmodel](https://www.nictiz.nl/wat-we-doen/zorginformatiestelsel/interoperabiliteit/lagenmodel-3/) - with *wet- en regelgeving* (legislation) and *beveiliging* (security) as conditions across all of them. This Implementation Guide mainly specifies the Informatie and Applicatie layers; the layers above and below it are established elsewhere.

<table class="grid">
  <thead>
    <tr><th>Layer</th><th>For this transaction</th><th>Where in this IG</th></tr>
  </thead>
  <tbody>
    <tr>
      <td style="background-color:#c1178c;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Organisatiebeleid</td>
      <td>Governance and agreements between the parties (ambulance/RAV, HAP), the <a href="https://www.nictiz.nl/document/richtlijn-gegevensuitwisseling-acute-zorg-versie-4-2022pdf">Richtlijn Gegevensuitwisseling Acute Zorg</a>, and the national release policy. Largely outside this technical IG.</td>
      <td><a href="index.html">Home</a>, Functional design (this page)</td>
    </tr>
    <tr>
      <td style="background-color:#29abe2;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Zorgproces</td>
      <td>The handover itself: an ambulance professional refers a patient to the HAP after on-scene care, one-directional PUSH.</td>
      <td><a href="use-cases.html">Use cases</a>, <a href="workflow.html">Workflow</a></td>
    </tr>
    <tr>
      <td style="background-color:#e4670a;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Informatie</td>
      <td>What is exchanged: the ART-DECOR dataset, the zibs and nl-core, and the dataset mappings.</td>
      <td><a href="data-model.html">Data model</a>, this page</td>
    </tr>
    <tr>
      <td style="background-color:#95c11f;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">Applicatie</td>
      <td>How systems exchange it: the FHIR R4 profiles, the message structure (MessageHeader/Bundle), CapabilityStatements and ActorDefinitions.</td>
      <td><a href="artifacts.html">Artifacts</a>, <a href="data-model.html">Data model</a></td>
    </tr>
    <tr>
      <td style="background-color:#009b3e;color:#fff;font-weight:600;text-align:center;white-space:nowrap;">IT-infrastructuur</td>
      <td>The transport: the exchange paradigm (FHIR Messaging, RESTful or FHIR Document), not yet chosen.</td>
      <td><a href="data-exchange.html">Data exchange</a></td>
    </tr>
  </tbody>
</table>

The two conditional columns, *wet- en regelgeving* and *beveiliging*, apply across every layer and are out of scope of this IG.

### Use case: Ambulanceverwijzing (AMB naar HAP), section 2.16

[Section 2.16 of the functional design](https://informatiestandaarden.nictiz.nl/wiki/az:Ontwerp_Acute_Zorg#Ambulanceverwijzing_.28AMB_.E2.86.92_HA.2FHAP.29) covers the handover of a patient by an ambulance professional to a GP out-of-hours post (HAP, *huisartsenpost*) after on-scene care. This corresponds to message 24 in the *richtlijn* (AMB naar HAP). The exchange is one-directional (PUSH): the ambulance/Regionale Ambulancevoorziening (RAV) sends, the HAP receives.

The information exchanged covers patient identification, the reason for referral, the treatment instituted on scene, the clinical conclusion or working diagnosis, and any supporting documents such as an clinical note or ECG.

### ART-DECOR dataset

The functional design is formalized in a machine-readable dataset in [ART-DECOR](https://decor.nictiz.nl/ad/#/hg-), the standard Dutch platform for defining healthcare information datasets.


There are two distinct ART-DECOR artefacts relevant to this IG:

Dataset - the shared catalog of data element definitions. Element identifiers (`hg-dataelement-NNNN`) are allocated here once and reused across transactions.

OID: `2.16.840.1.113883.2.4.3.11.60.103.1.1`, effective date 2020-10-19 - [view in ART-DECOR](https://decor.nictiz.nl/ad/#/hg-/datasets/dataset/2.16.840.1.113883.2.4.3.11.60.103.1.1/2020-10-19T17:52:39)

Transaction - the AMB-HAP-specific transaction definition (which elements are used, cardinalities, constraints). This is the published view to read when implementing or reviewing the exchange.

OID: `2.16.840.1.113883.2.4.3.11.60.103.4.145`, effective date 2025-06-10 - [view published transaction](https://decor.nictiz.nl/pub/eerstelijnszorg/hg-html-20260317T103425/tr-2.16.840.1.113883.2.4.3.11.60.103.4.145-2025-06-10T000000.html)

Each profile in this IG carries `Mapping` entries that trace FHIR elements back to their corresponding dataset element identifiers (`hg-dataelement-NNNN`). These mappings are visible on the Mappings tab of each profile page. See the [Design Decisions](design-decisions.html#dataset-traceability) page for the mapping conventions used.
