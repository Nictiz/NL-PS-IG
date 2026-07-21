// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation. Local code system to distinguish the two CDA externalDocument identifiers that are folded onto DocumentReference.identifier. FHIR defines no standard code for "document instance id vs set id" and leaves disambiguation of multiple identifiers to implementation context, so this small local system provides the discriminator values. Authored in FSH (not from ART-DECOR) because it is a structural/modelling code, not a clinical concept in the dataset.
CodeSystem: HgDocumentIdentifierType
Id: hg-document-identifier-type
Title: "hg document identifier type codes"
Description: "Local codes distinguishing the folded CDA externalDocument identifiers on `DocumentReference.identifier`: the document instance id (`.id`) and the version-independent set id (`.setId`)."
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #document-id "Document identifier" "Identifier of this specific document instance (CDA externalDocument `.id`)."
* #document-set-id "Document set identifier" "Version-independent identifier of the document set this instance belongs to (CDA externalDocument `.setId`)."
