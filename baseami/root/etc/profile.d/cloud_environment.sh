#!/bin/sh

source /dev/stdin <<META_DATA
$(/usr/local/bin/metadatavars)
META_DATA

source /dev/stdin <<USER_DATA
$(curl -s 'http://169.254.169.254/latest/user-data')
USER_DATA

