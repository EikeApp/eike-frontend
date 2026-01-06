import xml.etree.ElementTree as ET
import sys
import os

report_path = 'maestro/report.xml'

# Sicherstellen, dass die Datei existiert
if not os.path.exists(report_path):
    print(f"Error: Report file not found at {report_path}")
    sys.exit(1)

try:
    tree = ET.parse(report_path)
    root = tree.getroot()

    # Manchmal ist das Root-Element direkt 'testsuite', manchmal 'testsuites'
    if root.tag == 'testsuite':
        suites = [root]
    else:
        suites = root.findall('.//testsuite')

    # Fehler zählen
    failures = sum(int(s.attrib.get('failures', '0') or '0') for s in suites)
    errors = sum(int(s.attrib.get('errors', '0') or '0') for s in suites)

    print(f"JUnit parsed: failures={failures} errors={errors}")

    # Exit Code setzen: 0 wenn alles okay, 1 wenn Fehler gefunden wurden
    if failures == 0 and errors == 0:
        sys.exit(0)
    else:
        sys.exit(1)

except ET.ParseError:
    print("Error: Could not parse XML file.")
    sys.exit(1)
except Exception as e:
    print(f"An unexpected error occurred: {e}")
    sys.exit(1)
