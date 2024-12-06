#!/usr/bin/env bash
#set -x

# CAUTION:
#  This script should not be executed directly.
#  it is done by test_fsck.sh under created_manually / generated_during_use directory.

if [ ! -e "../${RESULT_DIR}" ]; then
	mkdir ../${RESULT_DIR}
fi

if [ $# -eq 0 ]; then
	TESTCASE_DIRS=$(find . -mindepth 1 -maxdepth 1 -type d)
	TEST_COUNT=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
else
	TESTCASE_DIRS=$@
	TEST_COUNT=$#
fi

for TESTCASE_DIR in $TESTCASE_DIRS; do
	if [ ! -e "${TESTCASE_DIR}/${IMAGE_FILE}.tar.xz" ]; then
		TEST_COUNT=$((TEST_COUNT - 1))
		continue
	fi

	echo "Running ${TESTCASE_DIR}" | tee -a $LOGFILE
	echo "===================================" | tee -a $LOGFILE

	# Set up image file as loop device
	tar -C . -xf "${TESTCASE_DIR}/${IMAGE_FILE}.tar.xz"
	if [ $NEED_LOOPDEV ]; then
		DEV_FILE=$(losetup -f "${IMAGE_FILE}" --show)
	else
		DEV_FILE=$IMAGE_FILE
	fi

	# Run fsck for repair
	${FSCK_PROG} ${FSCK_OPTS_AUTO} ${DEV_FILE} > >(tee -a $LOGFILE) 2> >(tee -a $LOGFILE > /dev/null)
	RET=${PIPESTATUS[0]}
	if [ ${RET} -ne 1 ] && [ ${RET} -ne 0 ]; then
		echo ""
		echo "Failed to repair ${TESTCASE_DIR}"
		if [ $NEED_LOOPDEV ]; then
			losetup -d "${DEV_FILE}"
		fi
		cleanup
	fi
	echo "-----------------------------------" | tee -a $LOGFILE

	# Run fsck again
	${FSCK_PROG_2} ${FSCK_OPTS_CHECK} ${DEV_FILE} > >(tee -a $LOGFILE) 2> >(tee -a $LOGFILE > /dev/null)
	RET=${PIPESTATUS[0]}
	if [ ${RET} -ne 0 ]; then
		echo "" | tee -a $LOGFILE
		echo "Failed, corrupted ${TESTCASE_DIR}" | tee -a $LOGFILE
		if [ $NEED_LOOPDEV ]; then
			losetup -d "${DEV_FILE}"
		fi
		cleanup
	fi
	echo "-----------------------------------" | tee -a $LOGFILE
	echo "Passed ${TESTCASE_DIR}" | tee -a $LOGFILE
	echo "===================================" | tee -a $LOGFILE
	echo "" | tee -a $LOGFILE
	PASS_COUNT=$((PASS_COUNT + 1))

	if [ $NEED_LOOPDEV ]; then
		losetup -d "${DEV_FILE}"
	fi
done
cleanup
