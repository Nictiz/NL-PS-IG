### Inleiding

Hier de informatie over de komende plugathon, waar het doel van is om de "Europese Patient Summary in de Nederlandse context" (NL-PS) te testen aan de hand van eigen data. Er zijn ook tests voor de invulling van Generiek Bouwblok (GBB)-profielen, maar de nadruk ligt op de NL-PS.

### Query

Normaal gesproken moet een PS gegenereerd worden met de FHIR query operatie $summary. Dat genereerd op basis van de laatste informatie in een systeem en een Composition-profiel van type Patient Summary (LOINC code 60591-5) een PS. Om deze plugathon simpel te houden hebben we er voor nu voor gekozen om de volgende query te hanteren:

```
GET [base]/Composition?type=http://loinc.org|60591-5/[id]/$document
```

Deze query haalt alle opgeslagen PS'en van een bepaalde patiënt op. De gegevens nodig om dit uit te voeren zijn:

1. een patient bearer token
2. een Composition-id (in de query aangegeven als "[id]")
3. een FHIR server URL die de NL-PS zal sturen

LET OP: bij het testen wordt alleen de eerst gevonden PS getest! Als je een specifieke PS wil testen, verwijder "$document" uit de query en voer deze uit. Kopieër dan uit het verkregen antwoord de id van de gewenste PS, en plak deze in de plaats van [id] in de query hierboven. Voer dan de query uit met het juiste id.

### Testscenario's

De scenario's die we willen testen op de plugathon hebben te maken met de eisen van de EHDS. Ze zijn te verdelen onder 2 sporen (EPS en NL-PS) met elk 4 niveaus, die soms maximaal of minimaal kunnen worden ingevuld. Hieronder een tabel met testomschrijvingen.
Voor de plugathon zijn zowel EPS als NL-PS instances nodig die kunnen voldoen aan deze scenario's. In verband met de hierboven beschreven query is het daarom handig om voor elk van de tests de id's op te schrijven van de PS'en die eraan kunnen voldoen.

| 1a | Lege Patient Summary met minimale Metadata                                                   | Profiel validatie, minimale Metadata, per section: lege entry, emptyReason gevuld, summary                                                                                                              |
| -- | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1b | Lege Patient Summary met maximale Metadata (NL)                                              | Profiel validatie, Maximale Metadata op basis PS composition, maximaal gevulde GBBs inclusief NL-toevoegingen in metadata, per section: lege entry, emptyReason gevuld, summary                         |
| 2  | Patient Summary met ongestructureerde samenvattingen                                         | Profiel validatie, minimale Metadata, per section: lege entry, inhoudelijke summary, handmatige controle op summary                                                                                     |
| 3a | Patient Summary met gestructureerde inhoud per sectie o.b.v. 1 GBB                           | Profiel validatie, minimale Metadata, per section: Eén referencein de entry naar minimaal gevulde GBB, inhoudelijke summary, handmatige controle op summaries                                          |
| 3b | Patient Summary met maximaal dekkend gestructureerde inhoud per sectie o.b.v. 1 GBB (NL)     | Profiel validatie, minimale Metadata, per section: Eén reference in de entry naar maximaal gevulde GBB inclusief NL-toevoegingen, inhoudelijke summary, handmatige controle op summaries               |
| 4a | Patient Summary met gestructureerde inhoud per sectie o.b.v. 2 GBBs                          | Profiel validatie, minimale Metadata, per section: Twee references in de entry naar minimaal gevulde GBB, inhoudelijk samengestelde summary, handmatige controle op summaries                           |
| 4b | Patient Summary met maximaal dekkend gestructureerde inhoud o.b.v. twee GBBs per sectie (NL) | Profiel validatie, minimale Metadata, per section: Twee references in de entry naar maximaal gevulde GBB inclusief NL-toevoegingen, inhoudelijk samengestelde summary, handmatige controle op summaries |

#### Opmerkingen

- De "Medicatie"-sectie, alhoewel verplicht in de EPS, staat voor deze plugathon buiten scope. Praktisch betekend dit dat de sectie medicatie alleen een emptyReason en uitleg in .text krijgt
- Het NL-PS-profiel heeft een imposeProfile-extensie op de EPS-Composition, wat betekend dat bij profielvalidatie de EPS ook wordt getest
- Met "metadata" wordt alles behalve de secties bedoelt, soms heet dit ook wel de "header"
- We testen alleen voor beschikbaarstellende systemen, nog geen ontvangende systemen
- Bij elke test zal een handmatige controle zijn voor het lezen van de .text elementen
