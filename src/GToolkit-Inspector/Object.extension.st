Extension { #name : #Object }

{ #category : #'*GToolkit-Inspector' }
Object >> gtInspectorForGtIn: composite [
	"this is a bridge solution to embed all views into the existing inspector"
	<gtInspectorPresentationOrder: 10>
	^ composite bloc
		title: '_GT';
		element: [ 
			| view |
			view := self gtViewsFor: GtPhlowView empty inContext: nil.
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
Object >> gtLiveFor: aView [
	"I am a utility method that can be useful for polymorphic purposes"
	self gtPrintFor: aView
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtPrintFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Print';
		priority: 110;
		text: [ self printString asRopedText monospace ]
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtRawFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Raw';
		priority: 100;
		items: [ 
			| variableNodes |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GTInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			variableNodes ];
		column: 'Icon' do: [:aColumn | 
			aColumn 
				itemStencil: [ :aNode |
					| icon |
					icon := ([ aNode rawValue gtInspectorIcon ifNil: [ aNode rawValue class systemIcon ] ]
						on: Error 
						do: [ :error | self iconNamed: #smallWarningIcon ]).
					icon asElement 
						margin: (BlInsets top: 3 left: 0 bottom: 3 right: 0 ) ];
				noResize ];
		column: 'Variable' do: [:aColumn |
			aColumn 
				itemFormat: [ :aNode | aNode label asRopedText ];
				matchParent ];
		column: 'Value' do: [ :aColumn |
			aColumn 
				itemFormat: [ :aNode |
					[ aNode rawValue gtDisplayString asRopedText ] 
						on: Error 
						do: [ aNode errorMessage asRopedText foreground: Color red ] ];
			matchParent ]
]
