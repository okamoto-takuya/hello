#!/bin/bash
#set -x

PROJ=hello
PROJ_LCOV_FILE=${PROJ}.info

PROJ_SVR_NAME=`hostname -i`
DEFAULT_EXPORT_DIR=${HOME}/public_html/lcov

EXPORT_DIR=${DEFAULT_EXPORT_DIR}
EXPORT_URL=http://${PROJ_SVR_NAME}/~${USER}/lcov/${PROJ}/index.html

#cd `dirname $0`

# Make sure the export directory exists.
mkdir -p ${HOME}/public_html/lcov

# Run lcov
lcov -c -d src -o ${PROJ_LCOV_FILE}

# Remove external trace data
rmv_target="opt/rh external/include build 4.9"
for target in $rmv_target
do
    lcov -r ${PROJ_LCOV_FILE} *${target}* -o ${PROJ_LCOV_FILE}
done

genhtml ${PROJ_LCOV_FILE} -o ${EXPORT_DIR}/${PROJ}


cat << EOF

  You can find result at following URL.

EOF

echo $EXPORT_URL

cat << EOF

  NOTE: Please make sure http server is configured to allow user directory access.

EOF
