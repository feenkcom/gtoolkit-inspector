Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionBrowseFor: anAction [
	<gtAction>
	^ anAction button
		priority: 70;
		id: GtInspectorBrowseButtonId;
		tooltip: 'Browse class for current object';
		icon: BrGlamorousVectorIcons emphasizedBrowse;
		action: [ :aButton | 
			aButton phlow
				spawnTool: (GtPhlowExplicitTool new
					name: self class name;
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
	^ BrGlamorousVectorIcons empty
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
		importantFutureExecutionConfiguration;
		priority: 100;
		items: [ | variableNodes |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GtInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			variableNodes ];
		children: [ :anInspectorNode | anInspectorNode childrenNodes ];
		column: 'Variable'
			do: [ :aColumn | 
				aColumn
					dataBinder: [ :itemElement :anInspectorNode | 
						| nodeIcon extraInfo |
						extraInfo := false.
						nodeIcon := [ anInspectorNode rawValue gtInspectorIcon
								ifNil: [ anInspectorNode rawValue class iconNamed: anInspectorNode rawValue class systemIconName ] ]
								on: Error
								do: [ :error | Smalltalk ui icons iconNamed: #smallWarningIcon ].

						itemElement
							removeChildren;
							addChild: nodeIcon asElement.

						itemElement
							addChild: (BrLabel new
									aptitude: BrGlamorousListLabelAptitude;
									text: anInspectorNode label;
									alignCenterLeft;
									fitContent).
									
						"(anInspectorNode isSlotNode
							and: [ (anInspectorNode isDefinedInADifferentClassThanHost) ])
							ifTrue: [
								itemElement
									addChild: (BrVerticalPane new fitContent; addChild: BrGlamorousVectorIcons upwards asElement) ]."

						anInspectorNode isWeakClassNode
							ifTrue: [ extraInfo := true.
								itemElement
									addChild: (BrLabel new
											aptitude: (BrGlamorousListLabelAptitude new
													foreground: itemElement theme button disabledTextColor);
											beMiniSize;
											text: 'weak class';
											alignCenterLeft;
											hMatchParent;
											vFitContent) ].

						anInspectorNode isEphemeronClassNode
							ifTrue: [ extraInfo := true.
								itemElement
									addChild: (BrLabel new
											aptitude: (BrGlamorousListLabelAptitude new
													foreground: itemElement theme button disabledTextColor);
											beMiniSize;
											text: 'ephemeron class';
											alignCenterLeft;
											hMatchParent;
											vFitContent) ].

						anInspectorNode isWeakReferenceNode
							ifTrue: [ extraInfo := true.
								itemElement
									addChild: (BrLabel new
											aptitude: (BrGlamorousListLabelAptitude new
													foreground: itemElement theme button disabledTextColor);
											beMiniSize;
											text: 'weak reference';
											alignCenterLeft;
											hMatchParent;
											vFitContent) ].

						anInspectorNode isEphemeronReferenceNode
							ifTrue: [ extraInfo := true.
								itemElement
									addChild: (BrLabel new
											aptitude: (BrGlamorousListLabelAptitude new
													foreground: itemElement theme button disabledTextColor);
											beMiniSize;
											text: 'ephemeron reference';
											alignCenterLeft;
											hMatchParent;
											vFitContent) ].

						extraInfo ifFalse: [ itemElement children last hMatchParent ].

						itemElement ];
					cellStencil: [ BrHorizontalPane new
							hMatchParent;
							vFitContent;
							alignCenter ] ];
		column: 'Value'
			text: [ :anInspectorNode | 
				[ anInspectorNode rawValue gtDisplayText ]
					on: Error , Halt
					do: [ anInspectorNode errorMessage asRopedText foreground: Color red ] ]
			weight: 2;
		send: #value;
		dynamicContextItems: [ :anElement :anInspectorNode | 
			anInspectorNode isSlotNode
				ifTrue: [ (GtViewCreator
						viewCreatorsForObject: anInspectorNode rawValue
						andSource: anInspectorNode key
						in: anInspectorNode hostObject class)
						collect: [ :creator | 
							creator selfObject: self.
							creator asMenuItem ] ]
				ifFalse: [ #() ] ];
		dynamicContextItems: [ :anElement :anInspectorNode | 
			Array
				streamContents: [ :aStream | 
					anInspectorNode isSlotNode
						ifTrue: [ 
							| aPhlowContext |
							aPhlowContext := GtPhlowContext new.
							aPhlowContext selfObject: anInspectorNode hostObject.
							aPhlowContext behavior: anInspectorNode hostObject class.
						
							GtCoderVariableTarget
								menuItemsForObject: anInspectorNode slot
								inContext: aPhlowContext
								hostElement: nil
								do: [ :aMenuItem | aStream nextPut: aMenuItem ] ] ] ];
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
