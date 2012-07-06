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

    gem 'ngramdistance-ffi', :require => 'ngramdistance'
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
following functions:
1. distance
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

2. token_sort_distance
	require 'ngramdistance'
    NGramDistance.token_sort_distance("hello bello", "bello hello") # returns 1.0

	The token sort approach involves tokenizing the string in question, sorting the tokens alphabetically, and then joining them back into a string. For example:
	"new york mets vs atlanta braves"   →→  "atlanta braves mets new vs york
	We then compare the transformed strings with a simple distance(). That nicely solves our ordering problem, as our helper function below indicates:
	NGramDistance.token_sort_distance("New York Mets vs Atlanta Braves", "Atlanta Braves vs New York Mets") ⇒ 1.0
	
	method signature is token_sort_distance(source,target,regex=' ',ngram=3,mode=PROPOSITIONAL)
	the arguments are same as distance function but with extra argument regex, character or string to split source and target

3. token_set_distance
	require 'ngramdistance'
    NGramDistance.token_sort_distance("hello", "hello hello") # returns 1.0
    
    Token Set

	The token set approach is similar, but a little bit more flexible. Here, we tokenize both strings, but instead of immediately sorting and comparing, we split the tokens into two groups: intersection and remainder. We use those sets to build up a comparison string.
	Here is an illustrative example:
	s1 = "mariners vs angels"
	s2 = "los angeles angels of anaheim at seattle mariners"

	Using the token sort method isn't that helpful, because the second (longer) string has too many extra tokens that get interleaved with the sort. We'd end up comparing:

	t1 = "angels mariners vs"
	t2 = "anaheim angeles angels los mariners of seattle vs"

	Not very useful. Instead, the set method allows us to detect that "angels" and "mariners" are common to both strings, and separate those out (the set intersection). Now we construct and compare strings of the following form

	t0 = [SORTED_INTERSECTION]
	t1 = [SORTED_INTERSECTION] + [SORTED_REST_OF_STRING1]
	t2 = [SORTED_INTERSECTION] + [SORTED_REST_OF_STRING2]

	And then compare each pair.

	The intuition here is that because the SORTED_INTERSECTION component is always exactly the same, the scores increase when (a) that makes up a larger percentage of the full string, and (b) the string remainders are more similar. In our example

	t0 = "angels mariners"
	t1 = "angels mariners vs"
	t2 = "angels mariners anaheim angels"
	NGramDistance.distance(t0, t1) ⇒ 0.83333
	NGramDistance.distance(t0, t2) ⇒ 0.4838
	NGramDistance.distance(t1, t2) ⇒ 0.54828
	NGramDistance.token_set_distance(t0,t2) ⇒ 0.6521


	NGramDistance.token_set_distance("hello hello world", "hello world") ⇒ 1.0

	method signature is token_set_distance(source,target,regex=' ',ngram=3,mode=PROPOSITIONAL)
	the arguments are same as distance function but with extra argument regex, character or string to split source and target
	




Author
======

* Copyright (c) 2012, Bali (mailbali@gmail.com)
* I ported from java source code of lucene-3.0.2.

License
=======
* Apache  2.0 LICENSE

