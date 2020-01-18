#!/bin/sh
#
# ${project trunk_description}
# Copyright (C) ${date %Y} ${copyright-owner}
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#   * Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#   * Neither the name of the ucsd-psystem-os project nor the names of its
#     contributors may be used to endorse or promote products derived from
#     this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

if [ "$$TEST_SUBJECT" = "fill me in" ]
then
    echo '    You must set the TEST_SUBJECT environment variable' 1>&2
    echo '    at the top of your test script to something' 1>&2
    echo '    descriptive.' 1>&2
    exit 2
fi

#
# Remember where we came from, so that we can refer back to it as necessary.
#
devdir=$$(pwd)
test $$? -eq 0 || exit 2

#
# We are going to create a temporary for running tests within.  This
# makes it easy to clean up after tests (just rm -r) and it means tests
# can be run even if the development directory is read only (e.g. for
# reviewers).
#
testdir=/tmp/ovcam.$$$$

#
# The tear_down function is used by all the ways of leaving a test
# script, so that they all clean up in exactly the same way.
#
tear_down()
{
    set +x
    cd $$devdir
    rm -rf $$testdir
}

#
# The pass function (command) is used to declare a test to have passed,
# and exit.  The exit code of 0 is dictated by Aegis, so Aegis can know
# the result of running the test.
#
# Note that we don't say what was being tested, because only failed
# tests are interesting, especially when your project get to the point
# of having hundreds of tests.
#
pass()
{
    tear_down
    echo PASSED
    exit 0
}

#
# The fail function (command) is used to declare a test to have failed,
# and exit.  The exit code of 1 is dictated by Aegis, so Aegis can know
# the result of running the test.
#
fail()
{
    tear_down
    echo "FAILED test of $$TEST_SUBJECT"
    exit 1
}

#
# The no_result function (command) is used to declare a test to have
# failed in an unexpected way, and exit.  This is used for any case
# where the "scaffolding" of a test does no succeed, effectively making
# the correctedness of the functionality being tested indeterminate.
# The exit code of 2 is dictated by Aegis, so Aegis can know the result
# of running the test.
#
no_result()
{
    tear_down
    echo "NO RESULT for test of $$TEST_SUBJECT"
    exit 1
}

#
# Create our testing directory and cd into it.
#
mkdir $$testdir
test $$? -eq 0 || exit 2
cd $$testdir
test $$? -eq 0 || no_result

#
# insert your test here...
#
blah blah blah
test $$? -eq 0 || fail

#
# The functionality exercised by this test worked.
# No other assertions are made.
#
pass
