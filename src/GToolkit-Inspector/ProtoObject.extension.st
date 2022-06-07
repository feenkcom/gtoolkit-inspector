Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionBrowseFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Browse class';
		icon: BrGlamorousVectorIcons emphasizedBrowse;
		action: [ :button | self gtBrowseFrom: button ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionInspectFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect Object';
		action: [ :button | button phlow spawnObject: self]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionInspectInWindowFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousIcons maximize;
		tooltip: 'Inspect Object in a New Window';
		action: [ (GtPager openWrappedOn: (GtInspectorTool forObject: self) title: ('GtInspector @ {1}' format: { self })) maximized ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActions [
	"This collects all view actions for the current object.
	By default, it simply looks for the #gtAction pragma.
	Subclasses might want to override it for more special behavior."
	<return: #Array of: #GtPhlowAction>
	^ GtPhlowActionsCollector new
		pragmaName: #gtAction;
		fromObject: self;
		collect
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtDisplayString [
	"display nothing by default"
	^ ''
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtIcon [
	^ BrGlamorousIcons empty
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
ProtoObject >> gtRawFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Raw';
		priority: 100;
		items: [ | variableNodes |
			variableNodes := self class allSlots
					collect: [ :slot | GtInspectorSlotNode hostObject: self slot: slot ].
			{(GtInspectorSelfNode hostObject: self)}, variableNodes ];
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
								ifNil: [ aNode rawValue class systemIcon ] ]
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
		column: 'Value'
			text: [ :aNode | 
				[ aNode rawValue gtDisplayString asRopedText ]
					on: Error , Halt
					do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: #value;
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
