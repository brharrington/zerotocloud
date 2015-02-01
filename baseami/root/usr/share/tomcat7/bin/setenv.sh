totalMemSize () {
  mem=$(cat /proc/meminfo  | awk '/MemTotal: / { print int($2 / 1024) }')
  echo $mem
}

heapSizeCalc () {
  mem=$(totalMemSize)
  p50=$(expr $mem / 2)
  fixed=$(expr $mem - 1024)
  if [ $mem -ge 10240 ]; then
    fixed=$(expr $mem - 5120)
  fi
  p90=$(expr $mem \* 9 / 10)
  retval=1024
  if [ $fixed -gt $p90 ]; then
    retval=$p90
  else
    if [ $fixed -gt $p50 ]; then
      retval=$fixed
    fi
  fi
  echo $retval
}

javaOptsHeapSizeCalc () {
  buf=$1
  mem=$(totalMemSize)
  size=$(heapSizeCalc)
  max=$(expr $size - $mem \* $buf / 100)
  echo "-XX:+UseG1GC -Xms${max}m -Xmx${max}m"
}

GCLOG=/var/log/tomcat7/gc.log

export JAVA_OPTS=""

export CATALINA_OPTS=" \
    -verbose:sizes \
    -XX:PermSize=128m -XX:MaxPermSize=128m \
    $(javaOptsHeapSizeCalc 0) \
    -XX:+HeapDumpOnOutOfMemoryError \
    -verbosegc \
    -XX:+DisableExplicitGC \
    -XX:+PrintGCDetails \
    -XX:+PrintGCDateStamps \
    -Xloggc:$GCLOG \
    "
