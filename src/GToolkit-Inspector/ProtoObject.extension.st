Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionBrowseFor: anAction [
	<gtAction>
	^ anAction button
		priority: 70;
		tooltip: 'Browse class for current object';
		icon: BrGlamorousVectorIcons emphasizedBrowse;
		action: [ :aButton | 
			aButton phlow
				spawnTool: (GtPhlowExplicitTool new
					name: self gtDisplayString;
					stencil: [ GtCoderElement forObject: self ]) ];
		primaryModifierAction: [ :aButton | self gtBrowseFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionInspectFor: anAction [
	<gtAction>
	^ anAction button
		priority: 76;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect current object';
		id: GtInspectorInspectButtonId;
		action: [ :aButton |
			aButton phlow spawnObject: self ];
		primaryModifierAction: [ :aButton |
				aButton phlow showObject: self ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActions [
	"This collects all view actions for the current object in a new context"
	<return: #Array of: #GtPhlowAction>
	
	^ self gtActionsInContext: GtPhlowContext new
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionsInContext: aPhlowContext [
	"This collects all view actions for the current object.
	By default, it simply looks for the #gtAction pragma.
	Subclasses might want to override it for more special behavior."
	
	<return: #Array of: #GtPhlowAction>
	^ GtPhlowActionsCollector new
		pragmaName: #gtAction;
		fromObject: self;
		context: aPhlowContext;
		collect
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtDisplayText [
	^ ((self class name first isVowel 
		ifTrue: ['an '] 
		ifFalse: ['a ']), 
			self class name) asRopedText
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtIcon [
	^ BrGlamorousIcons empty
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtIconName [
	^ #empty
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtInspect [ 
	^ (GtInspector openOn: self) maximized
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtInspectorIcon [
	^ nil
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtInspectorTitleString [
	^ GtPhlowLabelBuilder new 
		object: self; 
		build 
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtInspectorVariableNodesIn: aCollection [
	 self class allSlots do: [ :slot | 
	 	aCollection add: (GtInspectorProtoObjectNode 
	 		hostObject: self  index: slot index slotName: slot name) ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtRawFor: aView [
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
		column: 'Variable'
			do: [ :aColumn | 
				aColumn
					cellStencil: [ BrHorizontalPane new
							hMatchParent;
							vFitContent;
							alignCenter ];
					dataBinder: [ :itemElement :aNode | 
						| nodeIcon |
						nodeIcon := [ aNode rawValue gtInspectorIcon
								ifNil: [ aNode rawValue class iconNamed: aNode rawValue class systemIconName ] ]
								on: Error
								do: [ :error | Smalltalk ui icons iconNamed: #smallWarningIcon ].

						itemElement
							removeChildren;
							addChild: nodeIcon asElement;
							addChild: (BrLabel new
									aptitude: BrGlamorousListLabelAptitude;
									text: aNode label;
									alignCenterLeft;
									hMatchParent;
									vFitContent) ] ];
		column: 'Value'
			text: [ :aNode | 
				[ aNode rawValue gtDisplayText ]
					on: Error , Halt
					do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: #value;
		dynamicContextItems: [ :each | 
			each value isSlotNode
				ifTrue: [ (GtViewCreator
						viewCreatorsForObject: each value rawValue
						andSource: each value key
						in: each value hostObject class)
						collect: [ :creator | creator label -> [ :element | creator showOn: element ] ] ]
				ifFalse: [ #() ] ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject class >> gtSubclassesFor: aView [
	<gtView>
	self subclasses ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Subclasses';
		items: [ { self } ];
		sendTool: [ :aClass | GtClassCoderTool forClass: aClass  ];
		expandOneLevel;
		children: #subclasses
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsFor: aView [
	"this is the default entry method for retrieving the wrapper view containing all views"
	^ self gtViewsFor: aView inContext: GtPhlowContext new
		
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsFor: aView inContext: aContext [
	<return: #GtPhlowLabelledView>
	^ GtPhlowLabelledViewBuilder new
		object: self;
		view: aView;
		context: aContext;
		build
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsInContext: aContext [
	"This collects all views for the current object.
	By default, it simply looks for the #gtView pragma.
	The inspector can decice whether or not a presentation should be displayed.
	Subclasses might want to override it for more special behavior.
	aContext holds the context of the inspection session (i.e, the previous steps)"
	^ GtPhlowViewsCollector new
		fromObject: self;
		context: aContext;
		collect.
]
