#!/bin/bash

FLAVORS=(
  ahbenefits benni byersindustrial bradford fcccares foundationwell
  geotekconnect gtrbenefits harborfoods innofiberconnect magis
  morrison mcgriff mbp pecoconnect psf prosper rbha rollwell
  saint tustin ima strive acrisure aerodyneapex
)

FLAVORS=(
  bookmark
)

APPLICATION_IDS=("com.recode.ahbenefits" "com.recode.benni" "com.recode.bradford"
"com.recode.byersindustrial" "com.recode.fcccares" "com.recode.foundationwell"
"com.recode.gtrbenefits" "com.recode.geotekconnect" "com.recode.harborfoods"
"com.recode.innofiberconnect" "com.recode.magis" "com.recode.morrison" "com.recode.mcrriffjourney"
"com.recode.mybenefitplace" "com.recode.pecoconnect" "com.health.psf" "com.recode.prosper"
"com.recode.rbha" "com.recode.rollwell" "com.strivebenefits" "com.recode.saintfancistotalrewards"
"com.recode.tustin" "com.recode.imahealth" "com.recode.acrisure" "com.recode.aerodyneapex")

APPLICATION_IDS=("com.recode.bookmark")
ARTIFACT_DIR="../../artifact"
mkdir -p "${ARTIFACT_DIR}"

for i in "${!FLAVORS[@]}"
do
  FLAVOR=${FLAVORS[i]}
  APP_ID=${APPLICATION_IDS[i]}

    echo "[${FLAVOR}] cleaning before build..."
    flutter clean

    echo "[${FLAVOR}] getting plugins..."
    flutter pub get

    echo "[${FLAVOR}] generating appbundle"
    echo "[${FLAVOR}] applicationId: ${APP_ID}"
    MAIN_DART="lib/main_${FLAVOR}.dart"
    flutter build appbundle --release --flavor "${FLAVOR}" -t "${MAIN_DART}"

  # Copy the generated AAB to artifact dir with flavor name appended
  SRC_AAB="./build/app/outputs/bundle/${FLAVOR}Release/app-${FLAVOR}-release.aab"
  DEST_AAB="${ARTIFACT_DIR}/app-${FLAVOR}-release.aab"

  if [ -f "${SRC_AAB}" ]; then
    cp "${SRC_AAB}" "${DEST_AAB}"
    echo "Copied artifact to ${DEST_AAB}"

    echo "[${FLAVOR}] uploading to Google Play Store (production)..."
        fastlane supply \
          --aab "${DEST_AAB}" \
          --package_name "${APP_ID}" \
          --track production \
          --json_key "./app-distribution/bookmark-my-benefits-5b1a019d7ec8.json" \
          --metadata_path "./app-distribution/whatsnew" \
          --rollout 1.0 \
          --skip_upload_metadata true \
          --skip_upload_images true \
          --skip_upload_screenshots true

  else
    echo "Warning: AAB file not found for flavor ${FLAVOR} at expected path ${SRC_AAB}"
  fi

done

