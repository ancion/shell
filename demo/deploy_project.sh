#!/bin/bash

BASE_DIR=/DDTX/dubbo
TOMCAT_DIR=/DDTX/apache-tomcat-7.0.62
HISTORY_DIR=${BASE_DIR}/version$(data +"%Y%m%d%H%M%S")


if [ -d "${BASE_DIR}/package" ]; then
  rm -rf ${BASE_DIR}/package
fi
unzip ${BASE_DIR}/package.zip
mkdir ${HISTORY_DIR}

kill -9 `ps -ef | grep tomcat | grep -v grep | awk '{print $2}'`
/bin/bash  ${BASE_DIR}/stop-all.sh


mv ${TOMCAT_DIR}/extlib/odn-utils-0.0.1-SNAPSHOT.jar  ${HISTORY_DIR}/
mv ${TOMCAT_DIR}/extlib/odn-common-model-1.0-SNAPSHOT.jar  ${HISTORY_DIR}/
mv ${TOMCAT_DIR}/extlib/odn-dubbo-interface-0.0.1-SNAPSHOT.jar  ${HISTORY_DIR}/
mv ${TOMCAT_DIR}/webapps/odnMainFrame.war  ${HISTORY_DIR}/
rm -rf ${TOMCAT_DIR}/webapps/odnMainFrame

mv ${BASE_DIR}/lib/odn-utils-0.0.1-snapshot.jar  ${HISTORY_DIR}/odn-utils-0.0.1-SNAPSHOT.jar-lib
mv ${BASE_DIR}/lib/odn-common-model-1.0-snapshot.jar ${HISTORY_DIR}/odn-common-model-1.0-SNAPSHOT.jar-lib
mv ${BASE_DIR}/lib/odn-dubbo-interface-0.0.1-snapshot.jar ${HISTORY_DIR}/odn-dubbo-interface-0.0.1-SNAPSHOT.jar-lib
mv ${BASE_DIR}/lib/odn-* ${HISTORY_DIR}/

cp /DDTX/package/odn-dubbo-interface-0.0.1-SNAPSHOT.jar ${TOMCAT_DIR}/extlib/
cp /DDTX/package/odn-common-model-1.0-SNAPSHOT.jar ${TOMCAT_DIR}/extlib/
cp /DDTX/package/odn-utils-0.0.1-SNAPSHOT.jar ${TOMCAT_DIR}/extlib/
cp /DDTX/package/odnMainFrame.war ${TOMCAT_DIR}/webapps/

cp /DDTX/package/odn-common-model-1.0-SNAPSHOT.jar ${BASE_DIR}/lib
cp /DDTX/package/odn-utils-0.0.1-SNAPSHOT.jar ${BASE_DIR}/lib
cp /DDTX/package/odn-dubbo-interface-0.0.1-SNAPSHOT.jar ${BASE_DIR}/lib
cp /DDTX/package/odn-data-delivery-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
cp /DDTX/package/odn-digital-cable-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
cp /DDTX/package/odn-equipment-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
cp /DDTX/package/odn-order-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/
cp /DDTX/package/odn-base-service-0.0.1-SNAPSHOT.jar ${BASE_DIR}/


/bin/bash  ${TOMCAT_DIR}/bin/startup.sh
/bin/bash  ${BASE_DIR}/start-all.sh

