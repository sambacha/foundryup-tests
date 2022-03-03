#!/usr/bin/env bash

echo "libfoundryup testing harness"
echo "version 2022.02.26"

echo $BASH_VERSION
echo date +%T
sleep 1

setUp() {
	. '../libfoundryup'

	FOUNDRY_BIN_DIR=$(mktemp -d)
	pd=$FOUNDRY_BIN_DIR # alias to reduce character count
}

tearDown() {
	rm -rf $pd
}

testUseProgramNameEmpty() {
	use_program
	assertEquals 2 $?
}

testUseProgramVersionEmpty() {
	use_program forge
	assertEquals 3 $?
}

testUseProgramProgramsDirDoesntExist() {
	FOUNDRY_BIN_DIR='/non/existent'
	local msg=$(
		use_program forge 0.1.0 2>&1
		assertEquals 1 $?
	)
	assertEquals "Not installed: forge 0.1.0" "$msg"
}

testUseProgramNotInstalled() {
	local msg=$(
		use_program forge 0.1.0 2>&1
		assertEquals 1 $?
	)
	assertEquals "Not installed: forge 0.1.0" "$msg"
}

testUseProgramNotInstalledInstalledOne() {
	mkdir $pd/forge

	local msg=$(
		use_program forge 0.1.0 2>&1
		assertEquals 1 $?
	)
	assertEquals "Not installed: forge 0.1.0" "$msg"
}
