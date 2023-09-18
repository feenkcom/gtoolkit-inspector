Extension { #name : #Object }

{ #category : #'*GToolkit-Inspector' }
Object >> gtDisplayOn: stream [
	"This offers a means to customize how the object is shown in the GlamorousToolkit UI"
	^ self printOn: stream
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtDisplayString [
    "This offers a means to customize how the object is shown in the GlamorousToolkit UI.
    Do not override this method. Override gtDisplayOn: instead"

    | limitedString limit |
    limit := 1000.
    limitedString := String streamContents: [:s | self gtDisplayOn: s] limitedTo: limit.
    limitedString size < limit ifTrue: [^ limitedString].
    ^ limitedString , ' ...'
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtDisplayText [
	^ [ self gtDisplayString asRopedText ]
		on: Error 
		do: [ :e | e printString asRopedText foreground: Color red ]
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtInspectorIcon [
	^ self iconOrThumbnailOfSize: 16
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtInspectorVariableNodesIn: aCollection [
	"This is a helper method that adds to the given collection all nodes modeling named and 
	indexed attributes for the current object.
	Subclasses can override it to specialize what appears in the variables presentation."
	| indexableDisplayLimit top bottom topLimit bottomLimit |
	
	indexableDisplayLimit := GtInspector indexableDisplayLimit.        
	top := 1.
	bottom := self basicSize.
	topLimit    := indexableDisplayLimit min: bottom.
	bottomLimit := indexableDisplayLimit max: (bottom - indexableDisplayLimit).

	top to: topLimit do: [ :index | 
		aCollection add: (GtInspectorIndexedNode hostObject: self index: index) ].
	
	bottomLimit + 1 to: bottom do: [ :index |
		aCollection add: (GtInspectorIndexedNode hostObject: self index: index) ].
	
	aCollection
		addAll: ((self class allSlots sorted: [:a :b | a name <= b name ]) collect: [ :slot | 
			GtInspectorSlotNode hostObject: self slot: slot ])
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtInspectorVariableValuePairs [
	"This is a helper method that returns a collection of 
		variable_name -> value
	for the current object.
	Subclasses can override it to specialize what appears in the variables presentation"
	| bindings |
	bindings := OrderedCollection new.
	self gtInspectorVariableNodesIn: bindings.
	^ bindings collect: [ :aNode | aNode key -> aNode value ]
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtLiveFor: aView [
	"I am a utility method that can be useful for polymorphic purposes"
	^ self gtPrintFor: aView
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtPrintFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Print';
		priority: 110;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self printString asRopedText ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtSystemIconName [
	^ self systemIconName
]
