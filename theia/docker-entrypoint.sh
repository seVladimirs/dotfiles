#!/bin/bash

waitForProxy() {
  proxy_call_result='FAIL'
  retry_counter=0
  if [ -z "${HTTP_PROXY}" ]; then
    echo "No env HTTP_PROXY, do not wait for proxy to start (is this local machine?)"
  else
    echo "Waiting for proxy to respond on ${HTTP_PROXY}/liveness"
    while [ $retry_counter -le 60 ] && [ $proxy_call_result = 'FAIL' ]; do
      proxy_call_result=$(curl --proxy '' "${HTTP_PROXY}/liveness" -s -f -o /dev/null && echo 'SUCCESS' || echo 'FAIL')
      echo "Result of proxy request: ${proxy_call_result}"
      if [ $proxy_call_result != 'SUCCESS' ]; then
        sleep 1
      fi
      retry_counter=$(($retry_counter + 1))
      echo "Tried ${retry_counter} times"
    done
  fi
}

mkdir -p /home/user/projects
mkdir -p "/home/user/.webide/logs/"
export LOG_CONFIG_PATH="/home/user/.webide/logs/sapTheiaExtLogConfig.yaml"

# Create log config file if not exists
if [ ! -f $LOG_CONFIG_PATH ]; then
echo "log.level: warn" > $LOG_CONFIG_PATH
fi

# soft link for yeoman to discover generators from extbin
ln -sf /extbin/generators/lib/node_modules /home/user

# TODO support origin pattern with uuid for better separation between webviews
export THEIA_WEBVIEW_EXTERNAL_ENDPOINT={{hostname}}

# generate and apply /tmp/theia-env.sh for simple extension env updates
/usr/local/bin/node /theia/packages/simple-ext-metadata/lib/node/main.js
source /tmp/theia-env.sh

# theia might resolve plugins from the internet and might require proxy authorization header functionality (i.e. for DMZ)
waitForProxy
# specify full path to local node, to avoid mistakenly running a remote node provided by another sidecar
/usr/local/bin/node ./src-gen/backend/main.js --hostname=0.0.0.0 --startup-timeout 30000
