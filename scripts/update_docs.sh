APPLEDOC_PATH=`which appledoc`
PRODUCT_NAME="DVATableViewDatasource"
BASE_DIR="../"
$APPLEDOC_PATH \
--project-name "${PRODUCT_NAME}" \
--project-company "Develapps" \
--company-id "es.develapps" \
--output "${BASE_DIR}/${PRODUCT_NAME}Docs" \
--no-repeat-first-par \
--keep-undocumented-objects \
--keep-undocumented-members \
--keep-intermediate-files \
--no-warn-invalid-crossref \
--exit-threshold 2 \
--ignore .m \
--verbose 3 \
"${BASE_DIR}/Pod"
