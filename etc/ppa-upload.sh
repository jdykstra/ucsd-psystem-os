#!/bin/sh
#
# UCSD p-System Operating System
# Copyright (C) 2011 Peter Miller
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
set -e

project=ucsd-psystem-os
wwwdir=archive

AEGIS_PROJECT=${project}.cur
export AEGIS_PROJECT

RELEASES="$*"
if [ -z "$RELEASES" ]
then
    RELEASES="`cat /home/archives/ubuntu.release.names`"
    if [ -z "$RELEASES" ]
    then
        RELEASES="hardy karmic lucid maverick natty"
    fi
fi

PPA=ppa:pmiller-opensource/ppa

#find the project baseline
bl=`aegis -cd -bl`
dir=$bl/$wwwdir
f=`( cd $dir && ls *.tar.gz ) | tail -1`
if [ -z "$f" ]
then
    echo "can't find tarball" 1>&2
    exit 1
fi
tgz=$dir/$f

tdir=/tmp/${project}-ppa-$$

for release in $RELEASES
do
    cd /tmp
    rm -rf $tdir
    mkdir $tdir
    cd $tdir
    tar xzf $tgz
    cd ${project}-*

    PACKAGE=`head -1 debian/changelog | awk '{print $1}'`
    VERSION=`head -1 debian/changelog | awk '{print $2}' |
        sed -r -e 's/^\(//;s/\)$//'`

    sed -i -r -e "1s/\) [^;]+; /~${release}) ${release}; /" debian/changelog
    head -1 debian/changelog
    dpkg-buildpackage -S -sa
    ls -lho ..
    dput $PPA ../${PACKAGE}_${VERSION}~${release}_source.changes

    cd /tmp
    rm -rf $tdir
done
exit 0

# vim:ts=8:sw=4:et
