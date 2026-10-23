### Inleiding

In deze leeswijzer vind je meer informatie over de plugathon op 4 november. Het doel is om de "Europese Patient Summary in de Nederlandse context" (NL-PS) en de onderliggende Generieke Bouwblokken (GBBs) te testen. Het wordt een test- en leeromgeving. Het doel is niet om aan te tonen dat een systeem voldoet aan een afgeronde standaard. De resultaten zijn dan ook geen formele kwalificatie. We testen de rol beschikbaarstellen van de NL-PS aan de hand van eigen data. Voor een effectief test-event is voorbereiding nodig van de deelnemers, dat lees je verder op.

### Query

De specificaties van de IPS en de EPS bevatten nog geen normerende afspraken rondom de query voor PS, op dit moment wordt aanbevolen of met de summary operation op de Patient resource te werken of met de docref operatie op een DocumentReference resource [Generation and Data Inclusion - International Patient Summary Implementation Guide v2.0.1](https://www.hl7.org/fhir/uv/ips/en/Generation-and-Data-Inclusion.html). Deze operaties zijn voor de plugathon niet praktisch en met de volgende operaties bereiken we hetzelfde resultaat. Voor deze testen is de preconditie dat Conformancelab de compositions kan vinden, en dus moeten de compositions daarvoor klaarstaan in het systeem. Daarom werken wij op de plugathon met de volgende twee opeenvolgende operaties.


Eerst zoekt Conformancelab naar de Compositions van het type Patient Summary:
```
GET [base]/Composition?type=http://loinc.org|60591-5
```



Vervolgens haalt Conformancelab de juiste PS composition op inclusief alle resolvable resources op. De juiste composition wordt bepaald middels de patient bearer token per gekozen testscenario: 

```
GET [base]/Composition/[id]/$document
```


# Testscenario's

De scenario's die we willen testen op de plugathon zijn afgeleid van de eisen van EHDS en is opgebouwd in niveau's van minst gestructureerd naar meest gestructureerd en rijkgevuld. Elk van de testen controleert of het bericht EU-compliant is opgesteld. De niveaus zijn verdeeld onder 2 sporen: een minimaal bericht met controles op alleen EU-eisen en een maximaal gevuld bericht inclusief NL-toevoegingen. Hieronder de testomschrijvingen in de tabel.

#### Opmerkingen
- Voor de plugathon is voor elk scenario minimaal één testinstances en testpatienten nodig om het scenario te testen.
- De "Medication Summary"-sectie staat voor deze plugathon buiten scope. Praktisch betekent dit dat de sectie medicatie alleen een emptyReason en uitleg voor ontbreken in .text krijgt.
- Het NL-PS-profiel heeft een imposeProfile-extensie op de EPS-Composition, wat betekent dat bij profielvalidatie de EPS ook steeds wordt getest.
- Met "metadata" wordt alles behalve de secties bedoelt, soms heet dit ook wel de "header".
- We testen alleen voor beschikbaarstellende systemen, nog geen ontvangende/raadplegende systemen.
- Bij elke test zal een handmatige controle zijn voor het lezen van de .text elementen. De test is te zien hoe de narrative summary opgesteld wordt in leesbare vorm op basis van gestructureerde data.


| **Niveau** | **Titel** | **Belangrijkste testen** | **Testdoel** |
| --- | --- | --- | --- |
| 1a | Lege Patient Summary met minimale Metadata | Profiel validatie, minimale Metadata, per section: lege entry, emptyReason gevuld, summary | Toetsen of het beschikbaarstellend systeem een lege NL-PS kan leveren, dat bevat:<br>* minimale metadata van de compostition,<br>* sections zonder inhoud en enkel met een emptyReason en human-readable gegenereerde summary(narrative).<br>* Deze test toetst ook of de Patient Summary conform de EU-PS opgesteld is. |
| 1b | Lege Patient Summary met maximale Metadata (NL) | Profiel validatie, Maximale Metadata op basis PS composition, maximaal gevulde GBBs inclusief NL-toevoegingen in metadata, per section: lege entry, emptyReason gevuld, summary | Toetsen of het beschikbaarstellend systeem een lege NL-PS met maximale metadata kan leveren inclusief Nederlandse aanvullingen, dat bevat:<br>* maximale metadata van de composition inclusief GBBs die maximaal gevuld zijn inclusief NL-toevoegingen,<br>* sections zonder inhoud en enkel met een emptyReason en human-readable gegenereerde summary(narrative).<br>* Deze test toetst ook of de Patient Summary conform de EU-PS opgesteld is. |
| 2 | Patient Summary met ongestructureerde samenvattingen | Profiel validatie, minimale Metadata, per section: lege entry, inhoudelijke summary, handmatige controle op summary | Toetsen of het beschikbaarstellend systeem een NL-PS kan leveren met header metadata en enkel ongestructureerde inhoud, dat bevat:<br>* minimale metadata van de compostition,<br>* elke section bevat een human-readable gegenereerde summary(narrative) op basis van eigen testdata.<br>* De section Medication Summary wordt verwacht met enkel een emptyreason en een generated summary.<br>* Deze test toetst ook of de Patient Summary conform de EU-PS opgesteld is. |
| 3a | Patient Summary met minimaal dekkend gestructureerde inhoud o.b.v. één GBBs per sectie | Profiel validatie, minimale Metadata, per section: Eén reference in de entry naar minimaal gevulde GBB, inhoudelijke summary, handmatige controle op summaries | Toetsen of het beschikbaarstellend systeem een NL-PS met minimaal dekkend gestructureerde inhoud kan leveren, dat bevat:<br>* minimale metadata van de compostition,<br>* per section 1 reference in de entry naar een minimaal gevulde GBB<br>* per section één human-readable gegenereerde summary(narrative).<br>* De section Medication Summary wordt verwacht met enkel een emptyreason en een generated summary.<br>* Deze test toetst ook of de Patient Summary conform de EU-PS opgesteld is. |
| 3b | Patient Summary met maximaal dekkend gestructureerde inhoud o.b.v. één GBBs per sectie (NL) | Profiel validatie, minimale Metadata, per section: Eén reference in de entry naar maximaal gevulde GBB inclusief NL-toevoegingen, inhoudelijke summary, handmatige controle op summaries | Toetsen of het beschikbaarstellend systeem een NL-PS met maximaal dekkend gestructureerde inhoud inclusief NL-toevoegingen kan leveren, dat bevat:<br>* minimale metadata van de compostition,<br>* per section 1 reference in de entry naar een maximaal gevulde GBB inclusief NL-toevoegingen<br>* per section één human-readable gegenereerde summary(narrative).<br>* De section Medication Summary wordt verwacht met enkel een emptyreason en een generated summary.<br>* Deze test toetst ook of de Patient Summary conform de EU-PS opgesteld is. |
| 4a | Patient Summary met minimaal dekkend gestructureerde inhoud o.b.v. twee GBBs per sectie | Profiel validatie, minimale Metadata, per section: Twee references in de entry naar minimaal gevulde GBB, inhoudelijk samengestelde summary, handmatige controle op summaries | Toetsen of het beschikbaarstellend systeem een NL-PS met minimaal dekkend gestructureerde inhoud op basis van meerdere GBBs kan leveren, dat bevat:<br>* minimale metadata van de compostition,<br>* per section 2 references in de entry naar een minimaal gevulde GBB<br>* per section één samengestelde human-readable gegenereerde summary(narrative).<br>* De section Medication Summary wordt verwacht met enkel een emptyreason en een generated summary.<br>* Deze test toetst ook of de Patient Summary conform de EU-PS opgesteld is. |
| 4b | Patient Summary met maximaal dekkend gestructureerde inhoud o.b.v. twee GBBs per sectie (NL) | Profiel validatie, minimale Metadata, per section: Twee references in de entry naar maximaal gevulde GBB inclusief NL-toevoegingen, inhoudelijk samengestelde summary, handmatige controle op summaries | Toetsen of het beschikbaarstellend systeem een NL-PS met maximaal dekkend gestructureerde inhoud op basis van meerdere GBBs kan leveren, dat bevat:<br>* minimale metadata van de compostition,<br>* per section 2 references in de entry naar een maximaal gevulde GBB inclusief NL-toevoegingen<br>* per section één samengestelde human-readable gegenereerde summary(narrative).<br>* De section Medication Summary wordt verwacht met enkel een emptyreason en een generated summary.<br>* Deze test toetst ook of de Patient Summary conform de EU-PS opgesteld is. |