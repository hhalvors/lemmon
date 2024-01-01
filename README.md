# Lemmon

A toolkit for elementary symbolic logic -- based on the system of
E.J. Lemmon (and Patrick Suppes) and Haskell (or possibly Agda). We
focus on classical logic, with some nods to intuitionistic. We hope
later to add support for substructural logics.

## To Do and Wish List

1. Create data types for Proposition, ProofLine, and Proof

2. Define Reconstrual, Extension of Reconstrual, and Substitution

3. Export a proof (qua Haskell data type) to txt, LaTeX, and possibly
   Markdown. (Get the length of the longest formula for formatting
   purposes?)

4. Operations on Proofs

	1. Substitution
	
	2. Replacement
	
	3. Increase all line numbers. (Make line numbers in proofs relative or something like that?)
	
	4. Push all assumptions to the start
	
	5. Convert to and from Fitch style
	
	6. Convert to and from Sequent style
	
5. Parser from String to Proposition

6. Convert from Proposition to TikZ parse tree
