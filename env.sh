#!/usr/bin/env bash
#set -x

# CAUTION:
#  This script should not be executed directly.
#  it is done by test_fsck.sh under created_manually / generated_during_use directory.

# $ENV from environment variable
FSCK_PATH=${ENV:-""}
RESULT_DIR="test_results"

TESTCASE_DIR=$1
NEED_LOOPDEV=$2
IMAGE_FILE=ntfs.img
FSCK_PROG=${FSCK_PATH}ntfsck
FSCK_PROG_2=${FSCK_PATH}ntfsck
FSCK_OPTS_AUTO="-a"
FSCK_OPTS_CHECK="-n"
PASS_COUNT=0
DATE=$(date +%Y%m%d%H%M%S)

cleanup() {
	echo ""
	echo "Passed ${PASS_COUNT} of ${TEST_COUNT}"
	rm -rf ${IMAGE_FILE}
	if [ ${PASS_COUNT} -ne ${TEST_COUNT} ]; then
		exit 1
	else
		exit 0
	fi
}
