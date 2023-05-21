;
; UCSD PASCAL - Version II.0
; Copyright (C) 1978, 1979 Regents of the University of California
; All Rights Reserved
;
; Permission to use, copy, modify and distribute any part of UCSD
; PASCAL solely authored by UC authors before June 1, 1979 for
; educational, research and non-profit purposes, without fee, and
; without a written agreement is hereby granted, provided that the
; above copyright notice, this paragraph and the following three
; paragraphs appear in all copies.
;
; Those desiring to incorporate UCSD PASCAL into commercial products or
; use for commercial purposes should contact the Technology Transfer &
; Intellectual Property Services, University of California, San Diego,
; 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
; Ph: (858) 534-5815, Fax: (858) 534-7345, E-Mail: invent@ucsd.edu.
;
; IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY
; FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES,
; INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF UCSD PASCAL, EVEN IF
; THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
; DAMAGE.
;
; THE SOFTWARE PROVIDED HEREIN IS ON AN "AS IS" BASIS, AND THE UNIVERSITY
; OF CALIFORNIA HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT,
; UPDATES, ENHANCEMENTS, OR MODIFICATIONS. THE UNIVERSITY OF CALIFORNIA
; MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES OF ANY KIND,
; EITHER IMPLIED OR EXPRESS, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
; WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR
; THAT THE USE OF UCSD PASCAL WILL NOT INFRINGE ANY PATENT, TRADEMARK OR
; OTHER RIGHTS.
;
; Case Number: SD1991-807 (2006)
; http://invent.ucsd.edu/technology/cases/1995-prior/SD1991-807.shtml
;
;;; Source: http://bitsavers.org/bits/UCSD_Pascal/ucsd_II.0/
;;;     U121.2_LSI-11_P-CODE_SOURCE.raw.gz

The following RT-11ish files are included with the I.5 UCSD PASCAL
system.  All files are copyright (c) 1978 Regents of the University of
California and are not to be copied on any media without the express
permission of the Institute for Information Systems.


        MACROS.MAC      Global definitions and macros for the interpreter
                        sources.  These should be assembled in front of all
                        sources, except the boot loaders.

        MAINOP.MAC      Interpreter section for most P-machine instructions

        PROCOP.MAC      Interpreter section for procedure call operators and
                        run-time support subroutines.

        IOTRAP.MAC      SYSCOM and trap-vector ASECT and console
                        device driver.

        QX.MAC          Driver for REMEX floppies on TERAK 8510 systems.
        RX.MAC          DEC floppy driver.
        RK.MAC          RK05 disk driver.
        TK.MAC          8510a screen emulator.
        LP.MAC          LP11 line printer driver.
        DL.MAC          DL11 transmit/recieve driver (this contains
                        seperate xmit and recieve drivers).
        RXBOOT.MAC      Bootloader for RX01 compatible drives.
        RKBOOT.MAC      Bootloader for RK05 compatible drives.
        QXBOOT.MAC      Bootloader for QX type REMEX drives.
        HARDFP.OBJ      Floating point package for systems with FPI
                        instruction set.
        SOFTFP.OBJ      Floating point package for systems without FPI
                        instruction set.
        DUMYFP.OBJ      A dummy floating point package for 'striped' interps.
        TERAK.MAC, LSI.MAC, EIS.MAC, 3.MAC        Option files (see below).

Assembly Instructions - - -

All files (except bootloaders) are assembled one-at-a-time
into .OBJ form with the following command line:

.R MACRO
*OBJFIL[,LSTFIL]=[OPTIONS,]MACROS,SRCFIL

The file names in brackets are optional.  The options file may set
any or all of several assembly-time options to customize the
resulting object to particular hardware configurations.  If no options
file is given, the resulting .OBJ file will run on any PDP/LSI 11
model computer.

The option file may include definitions of the following symbols:

        EIS     -       Causes code to be generated utilizing MUL, ASH, DIV,
                        ASHC, and SOB instructions.

        LSI     -       Causes code for MTPS, MFPS, and SOB instructions

        FPI     -       Causes code for FADD, FSUB, FMUL, and FDIV instructions
                        (These are 11/40 type floating point instructions, the
                         11/45 type instructions are not supported.)

        TERAK   -       Defines all of the above.

FPI should not be defined unless EIS is defined.

For LSI/11s with EISFIS chip, define all three.
For LSI/11s without the EISFIS chip, define only LSI
For 11/40s with EIS, define only EIS.
For 11/10s don't define any of the options.

Linking instructions - - -

.R LINK
*INTERP[,MAP]=IOTRAP,MAINOP,PROCOP[,DISK DRIVERS]/C/B:0
*<hard or soft or dumy>FP

The first three files must be in the above order.  Drivers may be in any
order.  Typically at least one disk driver plus LP and/or DL is placed
here.  The floating point stuff should be last.

To create boots - - -

.R MACRO
*<RK or RX or QX>BOOT[,LSTFIL]=<RK or RX or QX>BOOT
then
.R LINK
*<RK or QX>BOOT=<RK or QX>BOOT
the resulting file is the bootstrap.

The RX bootstrap is linked slightly differently.
.R LINK
*RXBOOT=RXBOOT/B:0
the resulting file is the bootstrap.

NOTE: A Pascal system with a bootstrap may coexist on a disk with an RT-11
directory.  The Pascal system MUST NOT have a duplicate directory.
To accomplish this the first entry in the Pascal directory must be
'RT-11.DIR[8]'.  This reserves the disk space where the RT-11 directory
resides.  There are no special files necessary under RT-11.  This is a very
convienient way to transfer a new interpreter from RT-11 to Pascal.  To
transfer an interp. you must figure out it's exact postion on the disk
(using an RT-11 extended directory listing) and then M(ake a Pascal
directory entry at the same physical location.
CARE MUST BE TAKEN TO MAKE SURE THAT RT-11 AND PASCAL FILES ARE NOT
WRITTEN ON TOP OF EACH OTHER ACCIDENTLY AND THEREBY DESTROYED.
