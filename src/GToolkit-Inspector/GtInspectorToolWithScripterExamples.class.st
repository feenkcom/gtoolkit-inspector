Class {
	#name : #GtInspectorToolWithScripterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> compositeToolWithObject [
	<gtExample>
	| anInspectorTool aScripter aCompositeTool |
	anInspectorTool := GtInspectorTool new object: GtInspectorExampleObject new.
	aCompositeTool := GtPhlowCompositeTool new
			addTool: anInspectorTool;
			addTool: (GtPhlowExplicitTool new
					stencil: [ BrFrame new
							background: Color random;
							matchParent ]).
							
	aCompositeTool asToolElementDo: [ :aToolElement | 
		aScripter := BlScripter new
				element: (BrFrame new
						matchParent;
						padding: (BlInsets all: 10);
						addChild: aToolElement);
				model: aCompositeTool ].
				
	self assert: aScripter isNotNil.

	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> compositeToolWithObject_fireCurrentToolUpdateWish [
	<gtExample>
	| aScripter someEvents anOldCompositeElement anOldInspectorElement |
	aScripter := self compositeToolWithObject.

	aScripter do
		label: 'Get current composite element';
		block: [ :aPhlowElement | anOldCompositeElement := aPhlowElement ];
		// #'Composite Tool';
		play.
		
	aScripter do
		label: 'Get current inspector element';
		block: [ :aPhlowElement | anOldInspectorElement := aPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	aScripter do
		label: 'Fire tool update wish';
		block: [ :anElement | anElement phlow fireCurrentToolUpdateWish ];
		// GtPhlowCompositeViewElementId;
		play.

	someEvents := aScripter events
			select: [ :each | each isKindOf: GtPhlowToolUpdateWish ].
	self assert: someEvents size equals: 1.
	self assert: someEvents anyOne isConsumed.

	aScripter assert
		label: 'Assert composite element is not replaced';
		satisfies: [ :aNewCompositeElement | anOldCompositeElement == aNewCompositeElement ];
		// #'Composite Tool';
		play.

	aScripter assert
		label: 'Assert inspector element is replaced';
		satisfies: [ :aNewInspectorElement | anOldInspectorElement ~~ aNewInspectorElement ];
		// GtPhlowLabelledViewElementId;
		play.
		
	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> compositeToolWithObject_fireToolUpdateWish [
	<gtExample>
	| aScripter someEvents anOldCompositeElement anOldInspectorElement |
	aScripter := self compositeToolWithObject.

	aScripter do
		label: 'Get current composite element';
		block: [ :aPhlowElement | anOldCompositeElement := aPhlowElement ];
		// #'Composite Tool';
		play.
		
	aScripter do
		label: 'Get current inspector element';
		block: [ :aPhlowElement | anOldInspectorElement := aPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	aScripter do
		label: 'Fire tool update wish';
		block: [ :anElement | anElement phlow fireToolUpdateWish ];
		// GtPhlowCompositeViewElementId;
		play.

	someEvents := aScripter events
			select: [ :each | each isKindOf: GtPhlowToolUpdateWish ].
	self assert: someEvents size equals: 1.
	self assert: someEvents anyOne isConsumed.

	aScripter assert
		label: 'Assert composite element is replaced';
		satisfies: [ :aNewCompositeElement | anOldCompositeElement ~~ aNewCompositeElement ];
		// #'Composite Tool';
		play.

	aScripter assert
		label: 'Assert inspector element is replaced';
		satisfies: [ :aNewInspectorElement | anOldInspectorElement ~~ aNewInspectorElement ];
		// GtPhlowLabelledViewElementId;
		play.
		
	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> explicitCompositeToolWithObject [
	<gtExample>
	| aScripter aCompositeTool anIteration |
	anIteration := 0.
	aCompositeTool := GtPhlowExplicitCompositeTool new
			toolStencil: [ | anInspectorTool aMainTool anIndex |
				anIteration := anIteration + 1.
				anInspectorTool := GtInspectorTool new object: GtInspectorExampleObject new.
				aMainTool := GtPhlowCompositeTool new addTool: anInspectorTool.
				anIndex := 1.
				anIteration
					timesRepeat: [ aMainTool
							addTool: (GtPhlowExplicitTool new
									name: ('tool {1}' format: {anIndex});
									stencil: [ BrFrame new
											background: Color random;
											matchParent ]).
						anIndex := anIndex + 1 ].
				aMainTool ].

	aCompositeTool
		asToolElementDo: [ :aToolElement | 
			aScripter := BlScripter new
					element: (BrFrame new
							matchParent;
							padding: (BlInsets all: 10);
							addChild: aToolElement);
					model: aCompositeTool ].

	self assert: aScripter isNotNil.
	
	aScripter assert
		label: 'Assert number of composite tool element tabs is two';
		satisfies: [ :anArray | anArray size = 2 ];
		// #'Composite Tool';
		/ #header;
		// BrTab; 
		play.

	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> explicitCompositeToolWithObject_fireCurrentToolUpdateWish [
	<gtExample>
	| aScripter someEvents anOldCompositeElement anOldInspectorElement |
	aScripter := self explicitCompositeToolWithObject.

	aScripter do
		label: 'Get current composite element';
		block: [ :aPhlowElement | anOldCompositeElement := aPhlowElement ];
		// #'Composite Tool';
		play.
		
	aScripter do
		label: 'Get current inspector element';
		block: [ :aPhlowElement | anOldInspectorElement := aPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	aScripter do
		label: 'Fire tool update wish';
		block: [ :anElement | anElement phlow fireCurrentToolUpdateWish ];
		// GtPhlowCompositeViewElementId;
		play.

	someEvents := aScripter events
			select: [ :each | each isKindOf: GtPhlowToolUpdateWish ].
	self assert: someEvents size equals: 1.
	self assert: someEvents anyOne isConsumed.

	aScripter assert
		label: 'Assert composite element is not replaced';
		satisfies: [ :aNewCompositeElement | anOldCompositeElement == aNewCompositeElement ];
		// #'Composite Tool';
		play.

	aScripter assert
		label: 'Assert inspector element is replaced';
		satisfies: [ :aNewInspectorElement | anOldInspectorElement ~~ aNewInspectorElement ];
		// GtPhlowLabelledViewElementId;
		play.
		
	aScripter assert
		label: 'Assert number of composite tool element tabs is two';
		satisfies: [ :anArray | anArray size = 2 ];
		// #'Composite Tool';
		/ #header;
		// BrTab; 
		play.
		
	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> explicitCompositeToolWithObject_fireToolUpdateWish [
	<gtExample>
	| aScripter someEvents anOldCompositeElement anOldInspectorElement |
	aScripter := self explicitCompositeToolWithObject.

	aScripter do
		label: 'Get current composite element';
		block: [ :aPhlowElement | anOldCompositeElement := aPhlowElement ];
		// #'Composite Tool';
		play.
		
	aScripter do
		label: 'Get current inspector element';
		block: [ :aPhlowElement | anOldInspectorElement := aPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	aScripter do
		label: 'Fire tool update wish';
		block: [ :anElement | anElement phlow fireToolUpdateWish ];
		// GtPhlowCompositeViewElementId;
		play.

	someEvents := aScripter events
			select: [ :each | each isKindOf: GtPhlowToolUpdateWish ].
	self assert: someEvents size equals: 1.
	self assert: someEvents anyOne isConsumed.

	aScripter assert
		label: 'Assert composite element is replaced';
		satisfies: [ :aNewCompositeElement | anOldCompositeElement ~~ aNewCompositeElement ];
		// #'Composite Tool';
		play.

	aScripter assert
		label: 'Assert inspector element is replaced';
		satisfies: [ :aNewInspectorElement | anOldInspectorElement ~~ aNewInspectorElement ];
		// GtPhlowLabelledViewElementId;
		play.
		
	aScripter assert
		label: 'Assert number of composite tool element tabs is three';
		satisfies: [ :anArray | anArray size = 3 ];
		// #'Composite Tool';
		/ #header;
		// BrTab; 
		play.
		
	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> inspectorToolWithObject [
	<gtExample>
	| aTool aScripter |
	aTool := GtInspectorTool new object: GtInspectorExampleObject new.
	aScripter := BlScripter new
			element: aTool asElement;
			model: aTool.

	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> inspectorToolWithObject_fireCurrentToolUpdateWish [
	<gtExample>
	| aScripter someEvents anOldPhlowElement |
	aScripter := self inspectorToolWithObject.

	aScripter do
		label: 'Get current view element';
		block: [ :aPhlowElement | anOldPhlowElement := aPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	aScripter do
		label: 'Fire tool update wish';
		block: [ :anElement | anElement phlow fireCurrentToolUpdateWish ];
		// GtPhlowCompositeViewElementId;
		play.

	someEvents := aScripter events
			select: [ :each | each isKindOf: GtPhlowToolUpdateWish ].
	self assert: someEvents size equals: 1.
	self assert: someEvents anyOne isConsumed.

	aScripter assert
		label: 'Assert view element is replaced';
		satisfies: [ :aNewPhlowElement | anOldPhlowElement ~~ aNewPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorToolWithScripterExamples >> inspectorToolWithObject_fireToolUpdateWish [
	<gtExample>
	| aScripter someEvents anOldPhlowElement |
	aScripter := self inspectorToolWithObject.

	aScripter do
		label: 'Get current view element';
		block: [ :aPhlowElement | anOldPhlowElement := aPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	aScripter do
		label: 'Fire tool update wish';
		block: [ :anElement | anElement phlow fireToolUpdateWish ];
		// GtPhlowCompositeViewElementId;
		play.

	someEvents := aScripter events
			select: [ :each | each isKindOf: GtPhlowToolUpdateWish ].
	self assert: someEvents size equals: 1.
	self assert: someEvents anyOne isConsumed.

	aScripter assert
		label: 'Assert view element is replaced';
		satisfies: [ :aNewPhlowElement | anOldPhlowElement ~~ aNewPhlowElement ];
		// GtPhlowLabelledViewElementId;
		play.

	^ aScripter
]
