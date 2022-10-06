Extension { #name : #Context }

{ #category : #'*GToolkit-Inspector' }
Context >> gtInspectorTempNodes [

	^ (self tempNames withIndexCollect: [ :tempName :tempIndex |
			GtInspectorContextNamedTempNode hostObject: self tempName: tempName tempIndex: tempIndex ]) .
]

{ #category : #'*GToolkit-Inspector' }
Context >> gtInspectorVariableNodesIn: aCollection [
	"We override the variables with context specific ones"
	| tempVariableValueNodes |
	
	tempVariableValueNodes := self gtInspectorTempNodes 
		sort: [ :aNode :anotherNode | aNode key < anotherNode key ].
	aCollection addAll: tempVariableValueNodes.
	super gtInspectorVariableNodesIn: aCollection
]

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
	^ aView tree
		title: 'Stack';
		items: [ self stack ];
		children: [ :anItem | anItem isContext ifTrue: [ anItem gtVariables ] ifFalse: [ #() ] ];
		itemText: [ :anItem | 
			anItem isContext
				ifTrue: [ anItem ]
				ifFalse: [ anItem key asRopedText
						append: ' := ' asRopedText;
						foreground: BrGlamorousColors disabledButtonTextColor;
						append: anItem value gtDisplayText ] ];
		send: [ :anItem | anItem isContext ifTrue: [ anItem ] ifFalse: [ anItem value ] ]
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
