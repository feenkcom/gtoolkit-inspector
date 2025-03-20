Extension { #name : #Collection }

{ #category : #'*GToolkit-Inspector' }
Collection >> gtCollectionSizeThreshold [
	"Return the maximum collection size that GT supports while showing all elements.
	When this threshold is reached, we no longer show certain views that would take too much resources."

	^ 16rFFFF "65535"
]

{ #category : #'*GToolkit-Inspector' }
Collection >> gtCreateViewSourceFor: aGtViewCreator [
	<gtViewCreator>
	| template bindings |
	 
	template := '{viewSelector} aView
	<gtView>
	{optionalNilCheck}
	^ aView columnedList
		title: ''{viewTitle}'';
		items: [ {objectComputation} asOrderedCollection ];
		column: ''Value'' text: [ :each | each gtDisplayString ]' .
	
	bindings := {
			'viewSelector' -> aGtViewCreator newSelector.
			'optionalNilCheck' -> (aGtViewCreator variable
				ifNil: [ '' ]
				ifNotNil: [ :aVariable | aVariable, ' ifNil: [ ^aView empty ].'] ).
			'viewTitle' -> aGtViewCreator title.
			'objectComputation' -> (aGtViewCreator variable 
				ifNil: [ '[ ', aGtViewCreator objectSource, ' ] value' ]
				ifNotNil: [ aGtViewCreator objectSource ])
		} asDictionary.
		
	aGtViewCreator
		source: (template format: bindings)
]

{ #category : #'*GToolkit-Inspector' }
Collection >> gtDisplayOn: stream [
	self printNameOn: stream.
	stream
		space;
		nextPut: $[;
		print: self size;
		nextPutAll: (' item' asPluralBasedOn: self size);
		nextPut: $];
		space.
	self size <= self gtCollectionSizeThreshold 
		ifTrue: [ self printElementsOn: stream ]
]

{ #category : #'*GToolkit-Inspector' }
Collection >> gtItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Items' translated;
		priority: 50;
		items: [ self asOrderedCollection ];
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		actionUpdateButtonTooltip: 'Update item list'
]
