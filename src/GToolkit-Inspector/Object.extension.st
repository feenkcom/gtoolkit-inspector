Extension { #name : #Object }

{ #category : #'*GToolkit-Inspector' }
Object >> gtInspectorForGtIn: composite [
	"this is a bridge solution to embed all views into the existing inspector"
	<gtInspectorPresentationOrder: 10>
	^ composite bloc
		title: '_GT';
		element: [ 
			| view |
			view := self gtViewsFor: GtPhlowView sequentialExplicit inContext: nil.
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
	^ aView explicit
		title: 'Print';
		priority: 110;
		stencil: [ BlTextElement new text: self printString asRopedText ]
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtRawFor: aView [
	<gtView>
	^ aView explicit
		title: 'Raw';
		priority: 100;
		stencil: [ 
			| variableNodes list |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GTInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			list := BrColumnedList new display: variableNodes.
			list addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :aNode | aNode rawValue ]).
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].

			list column
				title: 'Icon';
				stencil: [ :aNode :index |
					| icon |
					icon := ([ aNode rawValue gtInspectorIcon ifNil: [ aNode rawValue class systemIcon ] ]
							on: Error 
							do: [ :error | self iconNamed: #smallWarningIcon ]).
					icon asElement].
			list column
				title: 'Variable';
				stencil: [ :aNode :index | 
					| textElement text |
					text := aNode label asRopedText.								
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list column
				title: 'Value';
				stencil: [ :aNode :index |
					| text textElement |
					text := [ aNode rawValue gtDisplayString asRopedText ] 
						on: Error 
						do: [ aNode errorMessage asRopedText foreground: Color red ].
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ].
			  ].
			
			list ]
]
