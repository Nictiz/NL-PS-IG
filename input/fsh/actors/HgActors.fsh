// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// =============================================================================
// Obligation RuleSet - reusable across all referral use case profiles.
//
// Following the FHIR Obligations framework, support expectations are expressed as obligations bound to actors rather than the single mustSupport boolean.
//
// Two obligation pairings, picked by the element's cardinality. The Receiver obligation is the same in both (SHALL:no-error - accept the element without raising an error). The Sender obligation differs: for an optional element (min 0) the Sender SHALL populate it if it knows a value (SHALL:populate-if-known); for an element this IG makes mandatory (min >= 1) the Sender SHALL always populate it (SHALL:populate), since populate-if-known would contradict the 1..1/1..* cardinality. These are the producer/consumer pairings from the FHIR obligation code system (http://hl7.org/fhir/CodeSystem/obligation).
//
// Actor instances are defined per use case (see HgActorsAmbulanceHAP.fsh).
// =============================================================================

// Optional elements (min 0): Sender SHALL populate if known; Receiver SHALL not error. Insert with: * <element> insert Obligation
RuleSet: Obligation
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:populate-if-known
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorSender
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:no-error
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorReceiver

// Mandatory elements (min >= 1): Sender SHALL populate; Receiver SHALL not error. Insert with: * <element> insert ObligationMandatory
RuleSet: ObligationMandatory
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:populate
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorSender
* ^extension[$obligation][+].extension[code].valueCode = #SHALL:no-error
* ^extension[$obligation][=].extension[actor].valueCanonical = $hg-ActorReceiver
