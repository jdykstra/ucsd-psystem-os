#
# UCSD p-System Operating System
# Copyright (C) 2010 Peter Miller
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

The "arch" directory is populated with files and programs specific to
the microprocessor.

The "host" directory is populated with files and programs specific
to a particular brand of system, that contains within it one of the
microprocessors in the "host" directory.

For example, the skeleton of the "arch" directory would look something
like this:

arch/
    6502/
        assembler/
            # The assembler is written in Pascal.  There is a different
            # assembler for each microprocessor, but it is not tied to
            # any one architecture (brand).
            main.text
        interpreter/
            # The main body of the interpreter, except for the architecture
            # (brand) specific portions needed for disk controller and uart
            # support; those are accessed with a .include directive.
            main.asm.text
        decops/
            # The DECOPS procedure for the long_integer instrinsic unit.
            main.asm.text
        transcendental/
            # The assembler procedures for the transcendental instrinsic unit.
            main.asm.text
        turtle_graphics/
            # The assembler procedures for the turtle_graphics instrinsic unit.
            main.asm.text
    pdp11/
        ...structure as above, contents differ
    z80/
        ...structure as above, contents differ
    ...etc

For example, the skeleton of the "host" directory would look something
like this:

host/
    apple/
        interpreter/
            # The arch/${arch}/interpreter/arch.asm.text file will be
            # copied into the interpreter directory before the Makefile
            # assembles the interpreter, so that a single .include
            # directive is enough to customize the interpreter for the
            # host (brand).
            arch.asm.text
        boot/
            # The arch/${arch}/boot/main.asm.text file contaisn the boot code
            # that goes on the boot sectors of bootable disks will be
            # heavily device (brand) dependent, because it must work
            # with the boot roms of the specific device hardware present
            # in a host (brand).
            main.asm.text
        system/
            # The arch/${arch}/system/gotoxy.inc.text file contaisn the
            # Pascal code for moving the cursor.  Included by the
            # system, rather than having to use BINDER to glue it in
            # afterwards.
            gotoxy.inc.text
        # The arch/${arch}/miscinfo.text file contains the settings for
        # a specific system, to be able to move the cursor and recognize
        # arrow keys, rather than having to run SETUP after the system
        # is going.  Translated to binary bu ucsdpsys_setup from the
        # ucsd-psystem-xc project.
        miscinfo.text
    kim1/
        interpreter/arch.asm.text
        boot/main.asm.text
        system/gotoxy.text
        miscinfo.text
    terak/
        ...structure as above, contents differ
    lsi11/
        ...structure as above, contents differ
    trs80/
        ...structure as above, contents differ
    ...etc

The "klebsch" host refers to the Klebsch interpreter present in
the ucsd-psystem-vm project, used (by default) when emulating the
UCSD p-System.  In theory, you can use a "klebsch" host with any
microprocessor arch, but that has only been tested for the 6502.
