#!/bin/bash
#set -x

TEMP_RETURN="temp.log"

trap "rm ${TEST_DIR}/${TEMP_RETURN}; exit 1" SIGINT SIGTERM

if [ $# -eq 0 ]; then
	TEST_DIRS=$(find . -mindepth 1 -maxdepth 1 -type d | sort)
else
	TEST_DIRS=$@
fi

for TEST_DIR in $TEST_DIRS; do
	if [ ! -e "${TEST_DIR}/test_fsck.sh" ]; then
		continue
	fi

	echo
	echo "###############################################"
	echo "Test corrupted images in ${TEST_DIR}"
	echo "###############################################"
	sleep 2
	/bin/bash -c "cd ${TEST_DIR} && ENV=${FSCK_PATH} ./test_fsck.sh"
	RET=${PIPESTATUS[0]}
	result=$(tail -n 1 ${TEST_DIR}/${TEMP_RETURN})
	rm ${TEST_DIR}/${TEMP_RETURN}

	read PASS_COUNT TOTAL_COUNT <<< ${result}
	echo
	echo "###############################################"
	echo "Passed ${PASS_COUNT} of ${TOTAL_COUNT} in ${TEST_DIR}"
	echo "###############################################"
	echo
	if [ ${RET} -ne 0 ]; then
		echo "Failed to test for ${TEST_DIR} images"
		exit 1
	fi
done
