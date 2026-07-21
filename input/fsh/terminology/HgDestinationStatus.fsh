// NOTE: The explanatory comments in this file are AI-generated, for convenience and documentation. Bestemmingsstatus value set: the subset of ServiceRequest.status (FHIR R4 RequestStatus) used by the Ambulanceverwijzing. Bound (required) on hg-ReferralServiceRequest-AmbulanceHAP.status, narrowing the base required request-status binding to the three destination statuses.
ValueSet: HgDestinationStatus
Id: hg-destination-status
Title: "hg destination status"
Description: "Bestemmingsstatus: the subset of ServiceRequest.status (FHIR R4 RequestStatus) used by the Ambulanceverwijzing. Actief = active (patiënt is onderweg naar de bestemming); Geannuleerd = revoked (patiënt gaat niet meer naar de bestemming); Overgedragen = completed (patiënt is overgedragen aan de bestemming)."
* $request-status#active "Active"
* $request-status#revoked "Revoked"
* $request-status#completed "Completed"
