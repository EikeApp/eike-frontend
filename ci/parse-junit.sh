#!/bin/bash
set -eu

REPORT_PATH="maestro/report.xml"

# Sicherstellen, dass die Datei existiert
if [ ! -f "$REPORT_PATH" ]; then
  echo "Error: Report file not found at $REPORT_PATH"
  exit 1
fi

# XML parsen und Fehler/Failures zählen
FAILURES=$(grep -oP '(?<=failures=")[0-9]+' "$REPORT_PATH" | awk '{s+=$1} END {print s+0}')
ERRORS=$(grep -oP '(?<=errors=")[0-9]+' "$REPORT_PATH" | awk '{s+=$1} END {print s+0}')

echo "JUnit parsed: failures=$FAILURES errors=$ERRORS"

# Exit Code setzen: 0 wenn alles okay, 1 wenn Fehler gefunden wurden
if [ "$FAILURES" -eq 0 ] && [ "$ERRORS" -eq 0 ]; then
  exit 0
else
  exit 1
fi