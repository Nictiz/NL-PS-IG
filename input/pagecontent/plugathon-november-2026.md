### Inleiding

Hier de informatie over de komende plugathon, waar het doel van is om de Europese Patient Summary in de Nederlandse context (NL-PS) te testen aan de hand van eigen data. Er zijn ook tests voor de invulling van EU-Core- en Generiek Bouwblok (GBB)-profielen, maar de nadruk ligt op de EPS en NL-PS.

### Query

Normaal gesproken moet een PS gegenereerd worden van de laatste informatie in een systeem met de FHIR query operatie $summary. Om deze plugathon simpel te houden hebben we er voor nu voor gekozen de volgende query te hanteren:

```
GET [base]/Composition?type=http://loinc.org|60591-5/[id]/$document
```

Deze query haalt alle opgeslagen PS'en van een bepaalde patiënt op.
LET OP: bij het testen wordt alleen de eerst gevonden PS getest. Als je een specifieke PS wil testen, haal dan de $document van de query af en kopieër de id van de gewenste PS om te plakken in de plaats van [id] in de query hierboven beschreven.

### Testscenario's

De scenario's die we willen testen op de plugathon hebben te maken met de eisen van de EHDS. Ze zijn te verdelen onder 2 sporen (EPS en NL-PS) met elk 4 niveaus, die soms maximaal of minimaal kunnen worden ingevuld. Hieronder een tabel met testomschrijvingen.
Voor de plugathon zijn zowel EPS als NL-PS instances nodig die kunnen voldoen aan deze scenario's. In verband met de hierboven beschreven query is het daarom handig om voor elk van de tests de id's op te schrijven van de PS'en die eraan kunnen voldoen.

| Niveau | Titel                                             | Omschrijving                                                                                                           |
| ------ | ------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| 1a     | Minimum Metadata en lege secties                  | - Minimum Metadata (profiel validatie)<br />- Secties zonder entries, met emptyReasons, met redenatie in .text<br /> |
| 1b     | Maximum Metadata en lege secties                  | - Maximum metadata<br />- Secties zonder entries, met emptyReasons, met redenatie in .text<br />                      |
| 2      | Secties met alleen ongestructureerde samenvatting | - Secties zonder entries, met inhoudelijke summaries in .text<br />                                                 |
| 3a     | Minimale secties (entries)                        | - Secties met één entry waarvan de resource minimaal gevuld is, met inhoudelijke summaries in .text<br />           |
| 3b     | Maximale secties (entries)                        | - Secties met één entry waarvan de resource maximaal gevuld is, met inhoudelijke summaries in .text<br />           |
| 4a     | Minimale secties (2 entries)                      | - Secties met twee entries waarvan de resource minimaal gevuld zijn, met inhoudelijke summaries in .text<br />        |
| 4b     | Maximale secties (2 entries)                      | - Secties met twee entries waarvan de resource maximaal gevuld zijn, met inhoudelijke summaries in .text<br />       |


#### Opmerkingen

- Het enige verschil tussen EPS en NL-PS zijn de gebruikte profielen voor validatie
- Met "metadata" wordt alles behalve de secties bedoelt, soms heet dit ook wel de "header"
- De "Medicatie"-sectie kan gestructureerde entries nog niet aan, dus daar blijven we op niveau 2, ook in hogere niveaus
- We testen alleen voor beschikbaarstellende systemen, nog geen ontvangende systemen
- Bij elke test zal een handmatige controle zijn voor het lezen van de .text elementen
