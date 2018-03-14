#!/bin/sh
if [ ! -n "$1" ]; then
    echo "Usage: start.sh ( xxx.jar ... )"
    exit 1
else
    JAR_NAME="$1"
fi
HOST_IP=`curl http://rancher-metadata/latest/self/host/agent_ip 2>/dev/null`
PRIMARY_IP=`curl http://rancher-metadata/latest/self/container/primary_ip 2>/dev/null`
ENV_NAME=`curl http://rancher-metadata/latest/self/stack/environment_name 2>/dev/null`
SERVICE_NAME=`curl http://rancher-metadata/latest/self/service/name 2>/dev/null`
## memory
limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
soft_limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.soft_limit_in_bytes)
if [ "$soft_limit_in_bytes" -gt "8589934592" ]
then
    soft_limit_in_bytes=134217728
fi
# If not default limit_in_bytes in cgroup
#if [ "$limit_in_bytes" -ne "9223372036854775807" ]
if [ "$limit_in_bytes" -lt "8589934592" ]
then
    limit_heap_size=$(expr $limit_in_bytes - $soft_limit_in_bytes)
#    limit_in_megabytes=$(expr $limit_in_bytes \/ 1048576)
#    heap_size=$(expr $limit_in_megabytes - $RESERVED_MEGABYTES)
    heap_size=$(expr $limit_heap_size \/ 1048576S)
    export JAVA_OPTS="-Xmx${heap_size}m $JAVA_OPTS"
fi
JAVA_CMD=`which java`
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom $JAVA_OPTS"
JAVA_OPTS="-DHOST_IP=$HOST_IP $JAVA_OPTS"
JAVA_OPTS="-DPRIMARY_IP=$PRIMARY_IP $JAVA_OPTS"
JAVA_OPTS="-DENV_NAME=$ENV_NAME $JAVA_OPTS"
JAVA_OPTS="-DSERVICE_NAME=$SERVICE_NAME $JAVA_OPTS"

echo "    ENV_NAME : $ENV_NAME"
echo "SERVICE_NAME : $SERVICE_NAME"
echo "     HOST_IP : $HOST_IP"
echo "  PRIMARY_IP : $PRIMARY_IP"
echo "    JAR_NAME : $JAR_NAME"
echo "    JAVA_CMD : $JAVA_CMD"
echo "   JAVA_OPTS : $JAVA_OPTS"
echo " SPRING_OPTS : $SPRING_OPTS"
exec "$JAVA_CMD" ${JAVA_OPTS} -jar "$@" ${SPRING_OPTS}