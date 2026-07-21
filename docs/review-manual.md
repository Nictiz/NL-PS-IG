# Acute Zorg IG - aandachtspunten review

## Inleiding
Dit is de eerste echte FHIR R4 IG voor Nictiz: de FHIR-uitwerking van de ART-DECOR dataset + transactie _Verwijzing ambulance naar huisartsenpost_, die tot nu toe alleen als functioneel ontwerp/wiki + ART-DECOR bestond. Gebouwd in FSH (Sushi) + HL7 IG Publisher, op nl-core/zib2020. Omdat dit de eerste FHIR IG is, zit de meeste reviewwaarde in de fundamentele patronen hieronder: die goed krijgen bepaalt het sjabloon voor de volgende Acute Zorg-transacties, en zet mogelijk ook een standaard voor toekomstige FHIR IG's van Nictiz.

## Fundamentele patronen

- Gelaagde profielen Generieke, open-world hg-Referral\* profielen op FHIR core + een dunne use case-laag \*-AmbulanceHAP die kardinaliteiten/bindings/obligations toevoegt. Is dit het patroon dat Nictiz wil standaardiseren voor transactie-IG's?
- Obligations in plaats van mustSupport. Ondersteuning is uitgedrukt met het FHIR Obligations-framework (Sender SHALL:populate / populate-if-known, Receiver SHALL:no-error), gekoppeld aan Sender/Receiver ActorDefinitions. Dit is een bewuste afwijking van de gebruikelijke mustSupport-vlag.
- Relatie met ELZ. De generieke hg-Referral\* canonicals bestaan nu in zowel dit package als nictiz.fhir.nl.r4.elz; de bedoelde richting is ELZ -> Acute Zorg. Dit is een governance/eigenaarschapsbeslissing die Nictiz moet maken voordat een van beide een stabiele release bereikt (issue #13).

## Specifieke modelleerkeuzes

- Resource-mapping van de dataset. _Envelop_ -> ServiceRequest (de aanvraag), _Kern_ -> Composition (het document). De twee overlappen bewust: de ServiceRequest toont een paar Kern-velden (reasonCode, patientInstruction), en die worden gedupliceerd naar Composition-secties voor documentatie (ServiceRequest is leidend). Is deze triage-versus-documentatie-duplicatie de juiste keuze?
- zib Zorgaanbieder als Organization, niet als de Location-focusresource - omdat zender/ontvanger organisatorische adressering zijn, geen zorglocatie. Graag bevestigen dat deze afwijking van de nl-core focal-Location-richtlijn akkoord is.
- DocumentReference-identifiers, R5/R6-conform. masterIdentifier 0..0; CDA externalDocument .id/.setId op identifier, geslicet op een lokale type-code (document-id/document-set-id); versie op een extensie (-> native DocumentReference.version in R5/R6). De lokale type-code heeft geen FHIR-standaard equivalent en staat uit op de Zulip; vraagt expliciet om review (issue #4).
- Message events = ART-DECOR transacties (code = transactienummer, bijv. 145), gebonden op MessageHeader. Nog in ontwikkeling; gekoppeld aan de paradigmakeuze (issue #20).
- Patiëntnaam als vrije tekst (HumanName.text) volgens de (nog niet gepubliceerde) General Building Blocks-mapping, nog zonder dataset-element (issue #7).
- Terminologie. NL-editie SNOMED vastgezet via expansion-params; displayLanguage = nl; projectterminologie letterlijk ingebed vanuit ART-DECOR (Bijlagen value set + acutezorg-codesysteem-16) met behoud van hun OID/decor-canonicals via special-url. Graag bevestigen dat dit de manier is waarop Nictiz projectterminologie wil meenemen, en dat validatie tegen de Nictiz-terminologieserver moet draaien (niet tx.fhir.org).

## Openstaande beslissingen die een keuze van Nictiz vragen

- Uitwisselparadigma PUSH - Messaging / RESTful / Document nog niet gekozen (#14). Dit is de belangrijkste: het blokkeert het afronden van de CapabilityStatements en bepaalt of MessageHeader/Bundle en de message events überhaupt van toepassing zijn.
- ART-DECOR -> FHIR kardinaliteit/conformance-mapping (#5) - de huidige kardinaliteiten/obligations zijn een eerste interpretatie en kunnen nog wijzigen.
- Composition sectiecodes (#6), reasonCode ICPC\-binding (#3), DocumentReference.category value set (#2).
- Mapping-id's verifiëren + definitieve ART-DECOR publicatie-URL (#17).