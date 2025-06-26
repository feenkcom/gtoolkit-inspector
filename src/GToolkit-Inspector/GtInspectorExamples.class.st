Class {
	#name : #GtInspectorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #'examples - ui - content' }
GtInspectorExamples >> basicContentElement [
	<gtExample>
	<return: #GtInspectorContentElement>
	| anElement |
	anElement := GtInspectorContentElement new.
	anElement matchParent.
	self assert: anElement objectHolder equals: GtInspectorObject null.
	^ anElement
]

{ #category : #'examples - inspector' }
GtInspectorExamples >> basicInspector [
	<gtExample>
	<return: #GtInspector>
	| anInspector |
	anInspector := self basicInspectorClass new.
	self configureInspector: anInspector.
	^ anInspector
]

{ #category : #'examples - inspector' }
GtInspectorExamples >> basicInspectorClass [
	<gtExample>
	<return: #'GtInspector class'>
	^ GtInspector
]

{ #category : #'examples - ui - tool' }
GtInspectorExamples >> basicInspectorElement [
	<gtExample>
	<return: #GtInspector>
	| anElement |
	anElement := GtInspector new.
	anElement matchParent.
	self assert: anElement objectHolder equals: GtInspectorObject null.
	^ anElement
]

{ #category : #'examples - object holder' }
GtInspectorExamples >> basicObjectHolder [
	<gtExample>
	<return: #GtInspectorObject>
	| anInspector |
	anInspector := self basicObjectHolderClass new.
	^ anInspector
]

{ #category : #'examples - object holder' }
GtInspectorExamples >> basicObjectHolderClass [
	<gtExample>
	<return: #'GtInspectorObject class'>
	^ GtInspectorObject
]

{ #category : #'examples - ui - playground' }
GtInspectorExamples >> basicPlaygroundElement [
	<gtExample>
	<return: #LeInspectorPlaygroundElement>
	| anElement |
	anElement := (self class environment at: GtInspector embeddedPlaygroundName)
			new.

	anElement matchParent.
	self assert: anElement objectHolder equals: GtInspectorObject null.
	^ anElement
]

{ #category : #configuration }
GtInspectorExamples >> configureInspector: anInspector [
	<gtExample>
	anInspector aptitude: BrShadowAptitude.
	anInspector background: Color white.
	anInspector
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'examples - ui - content' }
GtInspectorExamples >> contentElement [
	<gtExample>
	<return: #GtInspectorContentElement>
	| anElement |
	anElement := self basicContentElement.
	anElement object: 42.
	self assert: anElement object equals: 42.
	^ anElement
]

{ #category : #'examples - updating' }
GtInspectorExamples >> fireToolUpdateWishFromContextMenu [
	"See https://github.com/feenkcom/gtoolkit/issues/4606"

	<gtExample>
	| aPager anObject aScripter someEvents |
	anObject := self inspectedObject.
	aPager := self basicInspectorClass createOn: anObject.
	self assert: aPager pages size equals: 1.
	self assert: anObject collection size equals: 10.
	self assert: (anObject collection includes: 7).

	aScripter := BlScripter new element: aPager.

	aScripter click
		label: 'Display tab Three';
		// BrTab;
		@ [ :aTab | aTab label asString = 'Three' ];
		play.

	aScripter assert
		label: 'Assert 10 items in the columned list';
		value: [ :anInfiniteList | anInfiniteList childrenCount ] equals: 10;
		// GtPhlowColumnedListId;
		/ #scrollable;
		play.

	aScripter menuStep
		openContextMenu;
		// GtPhlowColumnedListId;
		// GtPhlowCellElement;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		@ 1;
		play.

	aScripter menuStep
		clickMenuItemWithId: [ :anElement | 
			(anElement isKindOf: BrLabel)
				and: [ anElement text asString = 'Remove item (tool update wish)' ] ];
		onMenuContainer;
		play.

	aScripter click
		label: 'Display tab Three';
		// BrTab;
		@ [ :aTab | aTab label asString = 'Three' ];
		play.

	aScripter assert
		label: 'Assert 9 items in the columned list';
		value: [ :anInfiniteList | anInfiniteList childrenCount ] equals: 9;
		// GtPhlowColumnedListId;
		/ #scrollable;
		play.

	self assert: anObject collection size equals: 9.
	self assert: (anObject collection includes: 7) not.

	someEvents := aScripter events
			select: [ :each | each isKindOf: BrPhlowToolUpdateWish ].
	self assert: someEvents size equals: 2.
	self
		assert: (someEvents allSatisfy: #isConsumed)
		description: [ 'Event must be consumed' ].

	^ aScripter
]

{ #category : #'examples - updating' }
GtInspectorExamples >> fireViewUpdateWishFromContextMenu [
	"See https://github.com/feenkcom/gtoolkit/issues/4606"

	<gtExample>
	| aPager anObject aScripter someEvents |
	anObject := self inspectedObject.
	aPager := self basicInspectorClass createOn: anObject.
	self assert: aPager pages size equals: 1.
	self assert: anObject collection size equals: 10.
	self assert: (anObject collection includes: 7).

	aScripter := BlScripter new element: aPager.

	aScripter click
		label: 'Display tab Three';
		// BrTab;
		@ [ :aTab | aTab label asString = 'Three' ];
		play.

	aScripter assert
		label: 'Assert 10 items in the columned list';
		value: [ :anInfiniteList | anInfiniteList childrenCount ] equals: 10;
		// GtPhlowColumnedListId;
		/ #scrollable;
		play.

	aScripter menuStep
		openContextMenu;
		// GtPhlowColumnedListId;
		// GtPhlowCellElement;
		// BrLabel;
		@ [ :aLabel | aLabel text asString = '7' ];
		@ 1;
		play.

	aScripter menuStep
		clickMenuItemWithId: [ :anElement | 
			(anElement isKindOf: BrLabel)
				and: [ anElement text asString = 'Remove item (view update wish)' ] ];
		onMenuContainer;
		play.

	self assert: anObject collection size equals: 9.
	self assert: (anObject collection includes: 7) not.

	someEvents := aScripter events
			select: [ :each | each isKindOf: GtPhlowViewUpdateWish ].
	self assert: someEvents size equals: 2.
	self
		assert: (someEvents allSatisfy: #isConsumed)
		description: [ 'Event must be consumed' ].

	^ aScripter
]

{ #category : #'examples - inspected objects' }
GtInspectorExamples >> inspectedObject [
	<gtExample>
	<return: #GtInspectorExampleObject>
	^ self inspectedObjectClass new
]

{ #category : #'examples - inspected objects' }
GtInspectorExamples >> inspectedObjectClass [
	<gtExample>
	<return: #'GtInspectorExampleObject class'>
	^ GtInspectorExampleObject
]

{ #category : #'examples - ui - tool' }
GtInspectorExamples >> inspectorElement [
	<gtExample>
	<return: #GtInspector>
	| anElement |
	anElement := self basicInspectorElement.
	anElement object: 42.
	self assert: anElement object equals: 42.
	^ anElement
]

{ #category : #'examples - inspector in pager' }
GtInspectorExamples >> inspectorInPagerWithExampleObject [
	<gtExample>
	<return: #GtPager>
	| aPager anObject |
	anObject := self inspectedObject.
	aPager := self basicInspectorClass createOn: anObject.
	self assert: aPager pages size equals: 1.
	^ aPager
]

{ #category : #'examples - inspector' }
GtInspectorExamples >> inspectorWithExampleObject [
	<gtExample>
	<return: #GtInspector>
	| anInspector anObject |
	anInspector := self basicInspector.
	anObject := self inspectedObject.
	anInspector object: anObject.
	self assert: anInspector objectHolder object equals: anObject.
	^ anInspector
]

{ #category : #'examples - object holder' }
GtInspectorExamples >> objectHolderWithExampleObject [
	<gtExample>
	<return: #GtInspectorObject>
	| aModel anObject |
	aModel := self basicObjectHolder.
	anObject := self inspectedObject.
	aModel object: anObject.
	self assert: aModel object equals: anObject.
	^ aModel
]

{ #category : #'examples - ui - playground' }
GtInspectorExamples >> playgroundElement [
	<gtExample>
	<return: #LeInspectorPlaygroundElement>
	| anElement |
	anElement := self basicPlaygroundElement.
	anElement object: 42.
	self assert: anElement object equals: 42.
	^ anElement
]
