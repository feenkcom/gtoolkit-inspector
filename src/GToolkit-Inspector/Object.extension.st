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
		addAll: (self class allSlots collect: [ :slot | 
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
Object >> gtRawFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Raw';
		priority: 100;
		items: [ | variableNodes |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GtInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			variableNodes ];
		children: [ :aNode | aNode childrenNodes ];
		column: 'Variable' do: [ :aColumn |
			aColumn 
				cellStencil: [ 
					BrHorizontalPane new
						hMatchParent; 
						vFitContent;
						alignCenter ];
				dataBinder: [ :itemElement :aNode | 
					| nodeIcon |
					nodeIcon := [ 
						aNode rawValue gtInspectorIcon ifNil: [ 
							aNode rawValue class systemIcon ] ]
						on: Error
						do: [ :error | self iconNamed: #smallWarningIcon ].
					 
					itemElement
						removeChildren;
						addChild: nodeIcon asElement;
						addChild: (BrLabel new
							aptitude: BrGlamorousListLabelAptitude;
							text: aNode label;
							alignCenterLeft;
							hMatchParent;
							vFitContent) ] ];
		column: 'Value' text: [ :aNode | 
			[ aNode rawValue gtDisplayText ]
			on: Error , Halt
			do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: #value;
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
Object >> gtSystemIconName [
	^ self systemIconName
]
