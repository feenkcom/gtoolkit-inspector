Extension { #name : #Context }

{ #category : #'*GToolkit-Inspector' }
Context >> gtSourceFor: aView [
	<gtView>
	self method ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Source';
		priority: 10;
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ self gtBrowse ];
		stencil: [ (GtPharoMethodContextCoder forContext: self session: nil) asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #'*GToolkit-Inspector' }
Context >> gtStackFor: aView [
	<gtView>
	^ aView list
		title: 'Stack';
		items: [self stack]
]

{ #category : #'*GToolkit-Inspector' }
Context >> gtVariables [
	| aCollection |
	aCollection := OrderedCollection new.

	aCollection add: ('self' -> self receiver).
	
	self tempNames do: [ :aTempName | 
		| anAssoc |
		anAssoc := aTempName -> (self tempNamed: aTempName).
		aCollection add: anAssoc.
	].
	
	^ aCollection
]

{ #category : #'*GToolkit-Inspector' }
Context >> gtVariablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Variables';
		items: [ self gtVariables ];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: [ :anAssoc | anAssoc value ]
]
