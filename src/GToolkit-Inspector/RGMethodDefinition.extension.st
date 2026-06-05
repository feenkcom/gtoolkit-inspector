Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> asGtPharoMethodCoder [
	"It is assumed that users wants to see the actual method in all cases."
	|methodCoder|
	
	methodCoder := GtPharoMethodCoder forSmallMethod: self method.
	self hasGtHighlighter ifTrue: [	
		methodCoder highlighter: self gtHighlighter ].
						
	^ methodCoder 
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtActionInspectCompiledMethodFor: anAction [
	<gtAction>
	
	^ anAction button
		priority: 75;
		icon: BrGlamorousVectorIcons inspect;
		label: 'Inspect compiled method';
		target: GtPhlowObjectContextMenuTarget;
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		menuItemPreview: [self gtDisplayText];
		action: [ :aButton |
			aButton phlow spawnObject: self method ];
		primaryModifierAction: [ :aButton |
				aButton phlow showObject: self method ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtActionObjectDropdownFor: anAction [
	<gtAction>
	<gtToolAction>
	
	^ super gtActionObjectDropdownFor: anAction
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtDefaultInspectorTool [
	^ super gtDefaultInspectorTool
	"^ GtPhlowCompositeTool new
		addTool: (GtMethodDefinitionPhlowTool forMethodDefinition: self);
		addTool: super gtDefaultInspectorTool"
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtMethodCodersFor: aView [
	<gtView>
	<gtToolView>
	
	^ aView forward
		title: 'Method coders';
		priority: 25;
		object: [ self compiledMethod ];
		view: #gtMethodCodersFor:
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtSourceFor: aView [
	<gtView>
	<gtToolView>
	
	^ aView explicit
		title: 'Source';
		priority: 5;
		stencil: [ 
			self asGtPharoMethodCoder asExpandedOnlyElement vFitContentLimited ];
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: self method) ]
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtTreeFor: aView [
	<gtView>
	<gtToolView>
	
	self isDefined ifFalse: [ ^aView empty].
	
	^aView forward 
		title: 'AST';
		priority: 41;
		object: [ self method ];
		view: #gtASTTreeFor:
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtViewNodesExplanationWithLinksFor: aView [
	<gtView>
	<gtToolView>
	
	self isDefined ifFalse: [ ^aView empty].
	
	^aView forward 
		title: 'Syntax explanation';
		priority: 50;
		object: [ self method ];
		view: #gtViewNodesExplanationWithLinksFor:
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtViewPragmasFor: aView [
	<gtView>
	<gtToolView>
	
	self isDefined ifFalse: [ ^aView empty].
	
	^aView forward 
		title: 'Pragmas';
		priority: 45;
		object: [ self method ];
		view: #gtViewPragmasFor: 
]
