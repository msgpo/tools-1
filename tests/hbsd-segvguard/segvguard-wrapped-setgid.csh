#!/usr/bin/env tcsh

set TEST_NAME = "test-segvguard-wrapped-setgid"
set TEST_DIR = "/tmp/pax-tests/${USER}/segvguard/"

echo "${TEST_NAME}"

test -d ${TEST_DIR} || mkdir -p ${TEST_DIR}
cd ${TEST_DIR}

cat > ${TEST_NAME}.c<<__EOF
int
main(int argc, char **argv)
{
	volatile int *p = 0;

	return (*p);
}
__EOF

cc -O0 -o ${TEST_NAME} ${TEST_NAME}.c

chmod +s ${TEST_NAME}

cat > ${TEST_NAME}.sh<<EOF
#!./${TEST_NAME}
EOF

chmod +x ${TEST_NAME}.sh

repeat 6 ./${TEST_NAME}.sh

