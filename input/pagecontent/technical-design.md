#### Inleiding

Dit ontwerp beschrijft de uitwisselingtechnieken van de NL-PS. De functionele scope en rolverdeling staan in het [functionele ontwerp][fo]. Aansluitvoorwaarden voor identificatie, autorisatie en adressering volgen uit de gebruikte infrastructuur.

##### Bovenliggende specificaties

De NL-PS voldoet ook aan de specificaties van de [EPS][eps], die op haar beurt voldoet aan de specificaties van de [IPS][ips]. Dit wordt geregeld via de ["complies with profile"][complies]-extentie.

#### Transacties

##### NL-PS raadplegen en beschikbaarstellen

###### FHIR-queryspecificatie

De NL-PS wordt via de FHIR-operation $summary opgevraagd, zie de [IPS-operatiedefinitie][summary]. De operatie ondersteunt GET en POST; de voorbeelden gebruiken GET. Het antwoord is een `Bundle.type=document`. Zie ook de [FHIR-document specificatie][fhirdoc].
Aanroep met patiëntgebonden bearer token en bijbehorende logische Patient-id:

```http
GET [base]/Patient/[id]/$summary?profile=http://ig.nictiz.nl/nlps/StructureDefinition/nl-PatientSummary
Authorization: Bearer [token]
Accept: application/fhir+json or fhir+xml
```

Het NL-PS-profiel wordt voor beide mogelijkheden expliciet aangevraagd met de parameter `profile`. Deze parameter is optioneel in de IPS-operatiedefinitie; de server moet het aangevraagde NL-PS-profiel ondersteunen.

###### Patiëntidentificatie

Voor patiëntidentificatie zijn er twee mogelijkheden. Bij beide gelden de toegangsafspraken van de gebruikte infrastructuur.

1. **Bearer tokens.** De patiëntcontext wordt bepaald met een patiëntgebonden bearer token. De koppeling tussen het token en de patiënt volgt uit de infrastructuurafspraken. De client verstuurt het token in de HTTP-header `Authorization: Bearer [token]`, volgens [RFC 6750][bearer]. De `[id]` in de onderstaande aanroep moet overeenkomen met de patiëntcontext van het token.
2. **Patiëntidentifiers van een intern systeem.** De client geeft de patiëntidentifier uit het interne systeem mee via de operatieparameter `identifier`, met het identificerende systeem en de waarde (`[system]%7C[value]` in de URL). Deze route vereist serverondersteuning. De server koppelt de identifier aan de patiënt in het eigen systeem.

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
