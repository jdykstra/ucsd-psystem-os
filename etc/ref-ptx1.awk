#
# UCSD p-System Operating System
# Copyright (C) 2006, 2010 Peter Miller
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
function getc()
{
        getc_tmp = substr(getc_buf, getc_pos, 1)
        if (getc_tmp != "")
                ++getc_pos
        return getc_tmp
}

BEGIN {
        th_name = "none"
        th_section = "none"
        active = 0
}
/^\.TH/ {
        # watch out for the quotes
        getc_buf = $0
        getc_pos = 4
        argc = 0
        for (;;)
        {
                c = getc()
                while (c == " " || c == "\t")
                        c = getc()
                if (c == "")
                        break
                quoted = 0
                arg = ""
                for (;;)
                {
                        if (c == "\"")
                                quoted = !quoted
                        else if (c == "")
                                break
                        else if (!quoted && (c == " " || c == "\t"))
                                break
                        else
                                arg = arg c
                        c = getc()
                }
                argv[++argc] = arg
        }

        # th_name = argv[1]
        # gsub(/\\\*\(n\)/, "ucsd-psystem-os", th_name)
        # th_section = argv[2]
        th_name = FILENAME
        sub(/^.*\//, "", th_name)
        sub(/\.[0-9]$/, "", th_name)
        th_section = FILENAME
        sub(/^.*\./, "", th_section)
        active = 0
        next
}
/^\.SH/ {
        active = ($2 == "NAME")
        next
}
/^['.]\\"/ {
        # ignore comments
        next
}
/^['.]XX/ {
        # ignore indexing
        next
}
/^['.]/ {
        if (active)
        {
                sub(/^.[a-zA-Z][a-zA-Z]*[       ]*/, "")
                print th_name "(" th_section ") " $0
        }
        next
}
{
        if (active)
        {
                gsub(/  /, " ")         # Translate tabs to spaces
                gsub(/__*/, " ")        # Collapse underscores
                gsub(/  +/, " ")        # Collapse spaces
                gsub(/ *, */, ", ")     # Fix comma spacings
                sub(/^ /, "")           # Kill initial spaces
                sub(/ $/, "")           # Kill trailing spaces
                gsub(/\\f\(../, "")     # Kill font changes
                gsub(/\\f./, "")        # Kill font changes
                gsub(/\\s[-+0-9]*/, "") # Kill size changes
                gsub(/\\&/, "")         # Kill \&
                gsub(/\\\((ru|ul)/, "_")        # Translate
                gsub(/\\\((mi|hy|em)/, "-")     # Translate
                gsub(/\\\*\(n\)/, "ucsd-psystem-os")
                gsub(/\\\*\(../, "")    # Kill troff strings
                gsub(/\\/, "")          # Kill all backslashes
                print th_name "(" th_section ") " $0
        }
}
