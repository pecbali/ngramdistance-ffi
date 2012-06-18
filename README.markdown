ngramdistance-ffi
===============

Converted to FFI by Bali for Ruby portability.

This gem originally based on ngram distance.

Tested on:

* MRI 1.9.2

Known Issues
============
* The C extension uses `char*` strings, and so Unicode strings will give incorrect distances.


Including in Gemfile
====================

    gem ' ngramdistance-ffi', :require => ' ngramdistance'
Original README
===============

N-Gram version of edit distance based on paper by Grzegorz Kondrak, 
"N-gram similarity and distance". Proceedings of the Twelfth International 
Conference on String Processing and Information Retrieval (SPIRE 2005), pp. 115-126, 
Buenos Aires, Argentina, November 2005. 
http://www.cs.ualberta.ca/~kondrak/papers/spire05.pdf

This implementation uses the position-based optimization to compute partial
matches of n-gram sub-strings and adds a null-character prefix of size n-1 
so that the first character is contained in the same number of n-grams as 
a middle character.  Null-character prefix matches are discounted so that 
strings with no matching characters will return a distance of 0.

The module has a
single function:

    require 'ngramdistance'
    NGramDistance.distance("string1", "string2") == 1.0 # returns true
The code is made available under the following BSD license:

Copyright (c) 2009, Bali.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

- end -
