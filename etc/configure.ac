dnl!
dnl! UCSD p-System Operating System
dnl! Copyright (C) 2006, 2010, 2011 Peter Miller
dnl!
dnl! Redistribution and use in source and binary forms, with or without
dnl! modification, are permitted provided that the following conditions
dnl! are met:
dnl!
dnl!   * Redistributions of source code must retain the above copyright
dnl!     notice, this list of conditions and the following disclaimer.
dnl!   * Redistributions in binary form must reproduce the above
dnl!     copyright notice, this list of conditions and the following
dnl!     disclaimer in the documentation and/or other materials provided
dnl!     with the distribution.
dnl!   * Neither the name of the ucsd-psystem-os project nor the names
dnl!     of its contributors may be used to endorse or promote products
dnl!     derived from this software without specific prior written
dnl!     permission.
dnl!
dnl! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
dnl! "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
dnl! NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
dnl! FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
dnl! THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
dnl! INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
dnl! (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
dnl! SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
dnl! HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
dnl! STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
dnl! ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
dnl! OF THE POSSIBILITY OF SUCH DAMAGE.
dnl!
AC_INIT(install-sh)
dnl! AC_CONFIG_HEADER(config.h)
AC_PROG_INSTALL

AC_CHECK_PROGS(SOELIM, gsoelim soelim)

dnl
dnl     If the soelim program exists, and understands the -I option,
dnl     arrange for the Makefile to install the .ps files from the
dnl     documentation source files.
dnl
if test -n "$SOELIM"
then
  if $SOELIM -I. /dev/null > /dev/null 2>&1
  then
    : nothing
  else
    AC_MSG_RESULT([
        The $SOELIM program does not understand the -I option.
        GNU Groff 1.15 or later works correctly.
        See the BUILDING file for details.])
    GROFF=
  fi
fi

AC_CHECK_PROGS(GROFF, groff roff)
if test -n "$GROFF"
then
  HAVE_GROFF=yes
else
  HAVE_GROFF=no
  AC_MSG_RESULT([
        The Aegis documentation set and manual pages will
        be formatted and installed if you first install
        GNU Groff 1.15 or later and then re-run this ./configure script.
        Remember to use \`\`rm config.cache'' before you do.
])
fi
AC_SUBST(HAVE_GROFF)

dnl
dnl     Test to find a Bourne shell which understands functions
dnl
AC_MSG_CHECKING([for a Bourne shell which understands functions])
if test "z$SH" = "z"; then
    if test -f /bin/sh5; then
        SH=/bin/sh5
    else
        SH=/bin/sh
    fi
fi
AC_SUBST(SH)
AC_DEFINE_UNQUOTED(CONF_SHELL, ["$SH"],
[Set this to be the absolute path of a Bourne shell
which understands functions.])
AC_MSG_RESULT($SH)

dnl!
dnl! Evaluate some of the variables, to remove ${prefix} references.
dnl! This way, they can be used in C programs and Roff input.  Make sure
dnl! that ucsd-psystem-os is mentioned in the libdir and datadir paths;
dnl! add it if it is not already there.
dnl!
test "x$prefix" = xNONE && prefix="${ac_default_prefix-/usr/local}"
test "x$exec_prefix" = xNONE && exec_prefix="$prefix"
eval "exec_prefix=$exec_prefix"
eval "bindir=$bindir"
echo "bindir=$bindir" 1>&2
eval "datadir=$datadir"
eval "datarootdir=$datarootdir"
eval "libdir=$libdir"
eval "mandir=$mandir"
eval "sysconfdir=$sysconfdir"
eval "localstatedir=$localstatedir"
case "$libdir" in
*/ucsd-psystem-os/* | */ucsd-psystem-os )
        ;;
*)
        libdir="${libdir}/ucsd-psystem-os"
        ;;
esac
case "$localstatedir" in
*/ucsd-psystem-os/* | */ucsd-psystem-os )
        ;;
*)
        localstatedir="${localstatedir}/ucsd-psystem-os"
        ;;
esac

AC_OUTPUT(Makefile)
