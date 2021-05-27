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
		tooltip: 'Inspect object';
		action: [ :button | button phlow spawnObject: self]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionInspectInWindowFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousIcons maximize;
		tooltip: 'Inspect object in a new window';
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
ProtoObject >> gtIcon [
	^ BrGlamorousIcons empty
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtInspect [ 
	^ (GtInspector openOn: self) maximized
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
