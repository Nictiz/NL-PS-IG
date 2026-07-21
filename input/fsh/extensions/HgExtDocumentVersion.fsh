// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation. Document version label (CDA externalDocument versionNumber, DocumentVersienummer). R4 DocumentReference has no version element, so this extension is a forward-compatible bridge: it maps directly to the native DocumentReference.version element added in R5/R6, after which the extension can be retired. Value is string to match R5/R6 DocumentReference.version.
Extension: HgExtDocumentVersion
Id: hg-ext-DocumentVersion
Title: "hg document version"
Description: "Version label of the referenced document (CDA externalDocument versionNumber, DocumentVersienummer). Maps to DocumentReference.version in R5/R6."
* ^context[+].type = #element
* ^context[=].expression = "DocumentReference"
* value[x] only string
* valueString 1..1
