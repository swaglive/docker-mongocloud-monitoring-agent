#!/bin/bash

set -e

mkdir -p /var/log/mongodb-mms-automation
touch /var/log/mongodb-mms-automation/automation-agent.log \
      /var/log/mongodb-mms-automation/automation-agent-verbose.log

dockerize -template /etc/mongodb-mms-automation-agent/local.config:/etc/mongodb-mms-automation-agent/local.config \
    -stdout /var/log/mongodb-mms-automation/automation-agent-verbose.log -poll \
    mongodb-mms-automation-agent \
    -f /etc/mongodb-mms-automation-agent/local.config
