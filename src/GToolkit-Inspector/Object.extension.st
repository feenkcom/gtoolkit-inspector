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
		look: BrGlamorousCodeEditorLook;
		text: [ self printString asRopedText ]
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtRawFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Raw';
		priority: 100;
		items: [ | variableNodes |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GTInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			variableNodes ];
		column: 'Icon'
			icon: [ :aNode | 
				| icon |
				icon := [ aNode rawValue gtInspectorIcon
					ifNil: [ aNode rawValue class systemIcon ] ]
					on: Error
					do: [ :error | self iconNamed: #smallWarningIcon ].
				icon asElement
					margin: (BlInsets top: 3 left: 10 bottom: 3 right: 10) ]
			width: 36;
		column: 'Variable' text: [ :aNode | aNode label ];
		column: 'Value' text: [ :aNode | 
			[ aNode rawValue gtDisplayString asRopedText ]
			on: Error , Halt
			do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: #value
]
