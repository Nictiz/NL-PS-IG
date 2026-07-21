#!/usr/bin/env bash
# One-time setup of the GitHub issue tracker for the AZ-IG open items.
# Run from anywhere inside the repo (Nictiz/AZ-IG); requires the GitHub CLI (gh) and an
# authenticated session: `gh auth status`. Safe to re-run: labels use --force and the
# milestone is only created if missing. Issues are NOT de-duplicated - run the issue
# section once, or delete duplicates afterwards.
set -euo pipefail

MILESTONE="1.0.0"

echo "== Labels =="
# Open-item triage labels
gh label create open-item      --color BFD4F2 --description "Tracked open item / pending decision" --force
gh label create decision       --color D4C5F9 --description "Needs a modeling or design decision"  --force
gh label create terminology    --color C2E0C6 --description "Code systems / value sets / bindings"  --force
gh label create editorial      --color FEF2C0 --description "Editorial / documentation cleanup"     --force
gh label create infrastructure --color FAD8C7 --description "Build, tooling, publication"           --force
gh label create architecture   --color C5DEF5 --description "Cross-cutting architecture"            --force
# Release-note labels (consumed by .github/release.yml when generating release notes)
gh label create breaking-change --color B60205 --description "Incompatible change (major)"  --force
gh label create enhancement     --color 0E8A16 --description "New or improved (minor)"       --force
gh label create fix             --color 1D76DB --description "Compatible fix (patch)"        --force
gh label create documentation   --color 0075CA --description "Documentation only"           --force
gh label create ignore-for-release --color EEEEEE --description "Exclude from release notes" --force

echo "== Milestone =="
if ! gh api repos/{owner}/{repo}/milestones --jq '.[].title' | grep -qx "$MILESTONE"; then
  gh api repos/{owner}/{repo}/milestones -f title="$MILESTONE" \
    -f description="First publication (1.0.0): resolve open items before release." >/dev/null
  echo "created milestone $MILESTONE"
else
  echo "milestone $MILESTONE already exists"
fi

issue() { # title  labels  body
  gh issue create --title "$1" --label "$2" --milestone "$MILESTONE" --body "$3"
}

echo "== Issues =="
issue "DocumentReference.category: bind a value set" "open-item,decision,terminology" \
"\`category\` (CommunicatieCategorie, hg-dataelement-5463) is modeled and mapped but no value set is bound yet. Decide on a suitable zib/nl-core/generic value set. (Was on the IG Open Items page.)"

issue "ServiceRequest.reasonCode: constrain the ICPC coding?" "open-item,decision,terminology" \
"reasonCode.text is the mandatory free-text reason; an optional ICPC coding may accompany it. Open: whether to constrain reasonCode.coding to an ICPC binding/slice once the dataset fixes the code system."

issue "DocumentReference identifiers: confirm the R5/R6 type-code scheme" "open-item,decision" \
"Implemented: masterIdentifier 0..0, document/set id on identifier sliced by a local type code (hg-document-identifier-type), version on hg-ext-DocumentVersion. Open: confirm the local type-code scheme on the FHIR community chat (no standard code exists for instance-id vs set-id)."

issue "Map ART-DECOR cardinalities/conformance to FHIR cardinalities + obligations" "open-item,decision" \
"A systematic mapping from ART-DECOR cardinalities/conformance to FHIR cardinalities and the ObligationMandatory/Obligation split has not been made. Current cardinalities and obligations are a first interpretation and may change once mapped against the published transaction."

issue "Confirm Composition.section codes" "open-item,decision,terminology" \
"Section slice codes are provisional and under review: messageReason (SNOMED 440378000), treatmentGiven (LOINC 18776-5), diagnosisConclusion (LOINC 55110-1), agreedWithPatient (LOINC 69730-0)."

issue "Patient name as free text: define a dataset component for HumanName.text" "open-item,decision" \
"hg-Patient-AmbulanceHAP allows the full name as plain text on Patient.name.text when not registered structurally. No dataset component matches/represents this yet; follows the (not yet published) General Building Blocks (GBB) mapping. https://decor.nictiz.nl/ad/#/gbb2026bbr-/project/overview"

issue "Editorial cleanup pass" "editorial" \
"Cleanup round through the IG to remove duplicated instructions and repeated text across element comments, definitions and narrative pages."

issue "Download all bound terminology from ART-DECOR" "infrastructure,terminology" \
"Only the DocumentReference.type terminology is downloaded so far. Ensure all bound terminology is downloaded from ART-DECOR and kept in sync via the Nictiz downloadTerminology tool. Includes the expected offline 'No server available' expansion errors that resolve under a Nictiz terminology server."

issue "Run the Nictiz QA tooling in the build" "infrastructure" \
"In addition to HL7 IG Publisher QA, run the Nictiz QA tooling (GBB-IG/util/qa) and wire it into the build/CI before publication."

issue "Add a Downloads page" "infrastructure" \
"Add a Downloads page once the IG is published at a stable URL (npm install, package.tgz, full-ig.zip, definition zips). Likely superseded by the GitHub Releases page."

issue "Publication: version history and publication status" "infrastructure" \
"Wire up the formal FHIR publication (package-list.json, publication-request.json) and reconcile with the GitHub Releases-based changelog. The two expected pre-publication messages (package-list fetch, no publication request) resolve at publication time."

issue "Resolve canonical URL overlap with ELZ" "architecture,decision" \
"The generic hg-Referral* canonicals exist in both this package and nictiz.fhir.nl.r4.elz. Intended direction: ELZ depends on Acute Zorg. Reconcile before either reaches a stable release."

issue "Choose the exchange paradigm (Messaging / RESTful / Document)" "architecture,decision" \
"The exchange paradigm is not yet chosen. The CapabilityStatements and Data Exchange page will be finalized once decided."

issue "Message 23 (AMB naar HA) as a parallel use case" "architecture" \
"Out of scope for this version. Can be added as a parallel hg-Referral*-AmbulanceHA use case layer with a new ambulance-referral-to-ha event code; no changes to the HAP profiles required."

echo "== Done =="
