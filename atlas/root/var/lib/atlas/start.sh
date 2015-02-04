#!/bin/bash

typeset -x `stat --printf "userowner=%U\ngroupowner=%G\n" $0`

logDir=/var/log/atlas
mkdir -p $logDir && chown $userowner:$groupowner $logDir && chmod 755 $logDir

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

binDir=$(cd $(dirname $0) && pwd)
source /usr/share/tomcat7/bin/setenv.sh
exec /usr/bin/setuidgid $userowner $JAVA_HOME/bin/java $CATALINA_OPTS \
  -Djava.util.logging.manager=org.apache.logging.log4j.jul.LogManager \
  -Dlog4j.configurationFile=$binDir/log4j.xml \
  -jar "$binDir/main.jar"
