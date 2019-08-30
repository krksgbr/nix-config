VARIANT=${1?"Variant required"}
SCRIPT="build-$VARIANT.sh"
echo "Using script $SCRIPT"
docker run \
--rm \
--name build \
-v `pwd`/output:/src/dist \
-v `pwd`/build-scripts/${SCRIPT}:/src/${SCRIPT} \
-it iosevka-build-image /bin/bash ${SCRIPT}
