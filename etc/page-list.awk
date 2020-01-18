#!/bin/awk -f
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
function output_end()
{
        if (start == 0)
                return;
        if (middle != 0)
                printf(",")
        middle = 1
        printf("%d", start);
        if (start != finish)
                printf("-%d", finish);
        start = 0;
        finish = 0;
}

function output(n)
{
        if (start == 0)
        {
                start = n
                finish = n
                return
        }
        if (n == finish + 1)
        {
                finish = n;
                return
        }
        output_end();
        start = n;
        finish = n;
}

function output_even()
{
        if ((page[finish] % 2) != 0)
        {
                output_end();
                printf(",_");
        }
}

/Page:/ {
        page[$3] = $2
        if ($3 > max)
                max = $3
}
END {
        output(1);
        output(2);
        numtoc = 0
        for (j = 3; j <= max; ++j)
        {
                if (page[j] > 1000)
                {
                        output(j);
                        numtoc++
                }
        }
        output_even();
        for (j = 3; j <= max; ++j)
        {
                if (page[j] < 1000)
                        output(j);
        }
        output_even();
        output_end();
        printf("\n");
}
