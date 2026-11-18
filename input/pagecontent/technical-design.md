### Inleiding

Dit ontwerp beschrijft de uitwisselingtechnieken van de NL-PS. De functionele scope en rolverdeling staan in het [functionele ontwerp][fo]. Aansluitvoorwaarden voor identificatie, autorisatie en adressering volgen uit de gebruikte infrastructuur.

### Relatie met EPS en IPS

De NL-PS is een Nederlandse invulling van de [European Patient Summary (EPS)][eps], die voortbouwt op de [International Patient Summary (IPS)][ips]. Conformiteit aan de [EPS][eps] wordt gewaarborgt doormiddel van de ["complies with profile"][complies]-extensie.

### Transacties

#### NL-PS raadplegen en beschikbaarstellen

##### FHIR-operatie: $summary

De NL-PS wordt via de FHIR-operation $summary opgevraagd, zie de [IPS-operatiedefinitie][summary]. De operatie ondersteunt GET en POST; de voorbeelden gebruiken GET.

De client specificeert het NL-PS-Composition-profiel met de parameter `profile`. Deze parameter is binnen NL-PS verplicht, hoewel de IPS-operatiedefinitie deze optioneel maakt. De server moet dit profiel ondersteunen.

Bij een succesvolle aanroep retourneert de server een [FHIR-document][fhirdoc]: een `Bundle` met `type = document`, met als eerste resource een `Composition` die aan het aangevraagde profiel voldoet.

##### Query

```http
GET [base]/Patient/[id]/$summary?profile=http://ig.nictiz.nl/nlps/StructureDefinition/nl-PatientSummary
Accept: application/fhir+json or fhir+xml
```

In de query is expliciet geen methode van patiëntselectie gekozen. Hiervoor verwijzen wij naar het Authenticatie hoofdstuk van de standaard [Generieke Functies voor data-uitwisseling][GFauth] die ontwikkeld word door het Ministerie van Volksgezondheid, Welzijn en Sport (VWS).

[fo]: https://ig.nictiz.nl/nlps/nl/functional-design.html
[eps]: https://build.fhir.org/ig/hl7-eu/eps/en/index.html
[ips]: https://build.fhir.org/ig/HL7/fhir-ips/en/index.html
[complies]: https://build.fhir.org/ig/HL7/fhir-extensions/en/StructureDefinition-structuredefinition-compliesWithProfile.html
[fhirdoc]: https://hl7.org/fhir/R4/documents.html
[summary]: https://build.fhir.org/ig/HL7/fhir-ips/en/OperationDefinition-summary.html
[GFauth]: https://minvws.github.io/generiekefuncties-docs/en/authentication.html
