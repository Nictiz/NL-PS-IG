### Inleiding

Dit ontwerp beschrijft de uitwisselingtechnieken van de Patient Summary voor Nederland (NL-PS). De functionele scope en rolverdeling staan in het [functionele ontwerp][fo]. Aansluitvoorwaarden voor identificatie, autorisatie en adressering volgen uit de gebruikte infrastructuur.

### Relatie met EPS en IPS

De NL-PS is een Nederlandse invulling van de [European Patient Summary (EPS)][eps], die voortbouwt op de [International Patient Summary (IPS)][ips]. Conformiteit aan de [EPS][eps] wordt gewaarborgt doormiddel van de ["complies with profile"][complies]-extensie.

### Transacties

#### NL-PS raadplegen en beschikbaarstellen

##### FHIR-operaties

Door de link met de IPS kan de NL-PS via de FHIR-operaties [\$summary][summary] of [\$docref][docref] opgevraagd, zie de [IPS Data Generation and Inclusion][inclusion] pagina. De operatie ondersteunt GET en POST; de voorbeelden gebruiken GET.

Voor summary specificeert de client het NL-PS-Composition-profiel met de parameter `profile`. Deze parameter is binnen NL-PS verplicht, hoewel de IPS-operatiedefinitie deze optioneel maakt. De server moet dit profiel ondersteunen.

Bij een succesvolle aanroep retourneert de server een [FHIR-document][fhirdoc]: een `Bundle` met `type = document`, met als eerste resource een `Composition` die aan het aangevraagde profiel voldoet.

##### Voorbeeldquery met $summary

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
[docref]: http://hl7.org/fhir/uv/ipa/OperationDefinition-docref.html
[inclusion]: https://build.fhir.org/ig/HL7/fhir-ips/en/Generation-and-Data-Inclusion.html
[GFauth]: https://minvws.github.io/generiekefuncties-docs/en/authentication.html
