Extension { #name : #AdditionalMethodState }

{ #category : #'*GToolkit-Inspector' }
AdditionalMethodState >> gtPropertiesFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Properties';
		priority: 1;
		items: [ self properties associations ];
		column: 'Property' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
AdditionalMethodState >> gtSpecificSizeInMemory [
	"Include the pragmas (and their arguments array) and the associations that store properties.
	Property values are not included, as they are mostly shared objects (packages, trait compositions, booleans)."

	| size |
	size := self sizeInMemory.
	1
		to: self basicSize
		do: [ :anIndex | 
			(self basicAt: anIndex)
				ifNotNil: [ :anElement | 
					size := size + anElement sizeInMemory.
					anElement class == Pragma
						ifTrue: [ size := size + anElement arguments sizeInMemory ] ] ].
	^ size
]
