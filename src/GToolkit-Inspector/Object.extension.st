Extension { #name : #Object }

{ #category : #'*GToolkit-Inspector' }
Object >> gtDisplayText [
	^ [ self gtDisplayString asRopedText ]
		on: Error 
		do: [ :e | e printString asRopedText foreground: Color red ]
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtInspectorForGtIn: composite [
	"this is a bridge solution to embed all views into the existing inspector"
	<gtInspectorPresentationOrder: 10>
	^ composite bloc
		title: '_GT';
		element: [ 
			| view |
			view := self gtViewsFor: GtPhlowView empty.
			view asElementDo: [ :x | 
				x addEventHandlerOn: GtPhlowObjectToSelect do: [ :anEvent | 
					x fireEvent: (GLMBlocObjectToSelect new 
						toSelect: anEvent object; 
						fromElement: anEvent sourceElement) ].
				x addEventHandlerOn: GtPhlowObjectToSpawn do: [ :anEvent | 
					x fireEvent: (GLMBlocObjectToSelect new 
						toSelect: anEvent object; 
						fromElement: anEvent sourceElement) ] ] ]
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
		addAll: ((self class allSlots collect: [ :slot | 
			GtInspectorSlotNode hostObject: self slot: slot ]))
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
Object >> gtRawFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Raw';
		priority: 100;
		items: [ | variableNodes |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GtInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			variableNodes ];
		column: 'Icon'
			icon: [ :aNode | 
				[ aNode rawValue gtInspectorIcon
					ifNil: [ aNode rawValue class systemIcon ] ]
					on: Error
					do: [ :error | self iconNamed: #smallWarningIcon ] ]
			width: 36;
		column: 'Variable' text: [ :aNode | aNode label ];
		column: 'Value' text: [ :aNode | 
			[ aNode rawValue gtDisplayString asRopedText ]
			on: Error , Halt
			do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: #value;
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtSystemIconName [
	^ self systemIconName
]
