#!/bin/bash
set -eu

df -h
adb kill-server || true
adb start-server || true
adb devices || true

echo 'Waiting for emulator to be online...'
for i in $(seq 1 60); do
  STATE=$(adb devices | awk 'NR>1 && $1 ~ /emulator-5554/ {print $2}' | head -n1)
  echo "adb state: ${STATE:-none}"
  if [ "$STATE" = "device" ]; then
    break
  fi
  if [ "$STATE" = "offline" ]; then
    adb kill-server || true
    adb start-server || true
  fi
  sleep 2
done

adb devices
adb -s emulator-5554 wait-for-device

APK_PATH=build/app/outputs/flutter-apk/app-release.apk
test -f "$APK_PATH"
echo "Installing APK: $APK_PATH"
adb -s emulator-5554 install -r "$APK_PATH"
adb -s emulator-5554 shell input keyevent 82 || true

mkdir -p maestro

set +e
maestro test \
  --format=junit \
  --output=maestro/report.xml \
  --no-ansi .maestro
MAESTRO_EXIT=$?
set -e

echo "$MAESTRO_EXIT" > maestro/maestro_exit_code.txt
adb devices || true
adb -s emulator-5554 logcat -d -t 5000 > maestro/logcat.txt || true

exit "$MAESTRO_EXIT"