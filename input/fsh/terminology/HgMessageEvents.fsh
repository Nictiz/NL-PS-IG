// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation.
// Message event codes are based on the ART-DECOR transactions: one code per transaction, the code being the transaction number and the definition citing the transaction OID. Still under development; settled with the exchange-paradigm choice (see the Open Items page).
CodeSystem: HgMessageEvent
Id: hg-message-event
Title: "hg message event codes"
Description: "Message event codes for the Acute Zorg referral transactions. Each code is the number of the corresponding ART-DECOR transaction; the definition cites its OID."
* ^caseSensitive = true
* ^content = #complete
* #145 "Verwijzing ambulance naar huisartsenpost" "ART-DECOR transaction 2.16.840.1.113883.2.4.3.11.60.103.4.145 (Verwijzing ambulance naar huisartsenpost - AMB naar HAP, message 24)."

ValueSet: HgMessageEvents
Id: hg-message-events
Title: "hg message events"
Description: "Message events for the Acute Zorg referral transactions: the ART-DECOR transactions, identified by their transaction number in the hg-message-event code system."
* include codes from system HgMessageEvent
