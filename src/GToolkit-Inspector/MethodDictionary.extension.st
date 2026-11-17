Extension { #name : #MethodDictionary }

{ #category : #'*GToolkit-Inspector' }
MethodDictionary >> gtSpecificSizeInMemory [
	"A method dictionary keeps the selectors in its indexed slots and the methods in a separate values array.
	It does not store associations, so the Dictionary implementation (that adds the size of #associations)
	would count associations created only for the computation."

	^ self sizeInMemory + array sizeInMemory
]
