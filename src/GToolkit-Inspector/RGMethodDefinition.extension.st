Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtActionInspectCompiledMethodFor: anAction [
	<gtAction>
	
	^ anAction button
		priority: 75;
		icon: BrGlamorousVectorIcons inspect;
		label: 'CM';
		tooltip: 'Inspect compiled method';
		action: [ :aButton |
			aButton phlow spawnObject: self method ];
		primaryModifierAction: [ :aButton |
				aButton phlow showObject: self method ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 5;
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: self method) ];
		stencil: [ self method isBigMethod
				ifTrue: [ BrEditor new
						aptitude: BrGlamorousCodeEditorAptitude new;
						beReadOnlyWithSelection;
						text: ((self method sourceCode first: 10000) , '...') ]
				ifFalse: [ ((GtPharoMethodCoder forMethod: self method) asCoderViewModel
						withHeader;
						expanded: true;
						asElement) vFitContentLimited ] ]
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtTreeFor: aView [
	<gtView>
	
	self isDefined ifFalse: [ ^aView empty].
	
	^aView forward 
		title: 'Tree';
		priority: 60;
		object: [ self method ];
		view: #gtTreeFor:
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtViewNodesExplanationWithLinksFor: aView [
	<gtView>
	
	self isDefined ifFalse: [ ^aView empty].
	
	^aView forward 
		title: 'Syntax explanation';
		priority: 35;
		object: [ self method ];
		view: #gtViewNodesExplanationWithLinksFor:
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtViewPragmasFor: aView [
	<gtView>
	
	self isDefined ifFalse: [ ^aView empty].
	
	^aView forward 
		title: 'Pragmas';
		priority: 31;
		object: [ self method ];
		view: #gtViewPragmasFor: 
]
