ngramdistance-ffi
===============

Converted to FFI by Bali for Ruby portability.

This gem originally based on ngram distance or similarity algorithm from Proceedings of the Twelfth International 
Conference on String Processing and Information Retrieval (SPIRE 2005).

* This program was ported by hand from lucene-3.0.2. (lucene is Java product)
* It supports only ngram distance algorithm.


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
    NGramDistance.distance("string1", "string1") # returns 1.0
    NGramDistance.distance("university", "univearsitty",3) # returns 0.750000


method signature is distance(source,target,ngram=3,mode=PROPOSITIONAL)

Third argument is the ngram granularity.
* 1 -> unigram
* 2 -> bigram
* 3 -> trigram

default argument is 3 (tri-gram)

Fourth argument is mode of operation. We have 3 modes defined
* PROPOSITIONAL=0
	Propositional Computes the distance between n-grams with partial matching
* BINARY=1
	Only considers 2 n-grams match when they are exactly the same
* COMPLEX=2
	Uses ngramdistance with Binary option and 1-gram match for the n-gram match. 

default is PROPOSITIONAL mode.

Author
======

* Copyright (c) 2012, Bali (mailbali@gmail.com)
* I ported from java source code of lucene-3.0.2.

License
=======
* Apache  2.0 LICENSE

- end -
