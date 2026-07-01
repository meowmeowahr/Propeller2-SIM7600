#!/bin/bash
FILE="$(realpath --relative-to=. $1)"
BASE="${FILE%.*}"
SETTINGS=".vscode/settings.json"

jq --arg f "$FILE" --arg b "$BASE.binary" '
    ."spin2.fNameTopLevel" = $f |
    ."spin2.optionsBinaryFname" = $b
' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"

echo "Updated Spin2 Top-Level for: $BASE"