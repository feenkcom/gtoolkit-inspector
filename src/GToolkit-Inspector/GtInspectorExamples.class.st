Class {
	#name : #GtInspectorExamples,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtInspectorUtility',
	#classTraits : 'TBlDebug classTrait + TGtInspectorUtility classTrait',
	#instVars : [
		'phlowDemo'
	],
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #updating }
GtInspectorExamples >> addFooViewMethod [
	<gtExample>
	| anInspector aClass anInstance aFirstPageContentElement aSecondPageContentElement aTask aFirstPagerPageModel aFirstBrTabGroup aSecondPagerPageModel aSecondBrTabGroup aFirstTabbar aFirstTabs aSecondTabbar aSecondTabs |
	phlowDemo ensureFooMethodRemoved.
	phlowDemo emptyViewMethodDefinition.
	anInspector := self basicInspector.
	aClass := phlowDemo demoSubClass.
	anInstance := aClass new.
	anInspector spawnInitial: anInstance.
	aFirstPagerPageModel := anInspector pager pages first.
	aFirstPageContentElement := aFirstPagerPageModel widget childNamed: anInspector contentIdentificator.
	aFirstBrTabGroup := self utility compositeViewElementInPagerPageModel: aFirstPagerPageModel.
	aFirstTabbar := aFirstBrTabGroup childNamed: #tabbar.
	aFirstTabs := aFirstTabbar children asArray.
	self assert: anInspector taskQueue tasks size equals: 0.
	self assert: aFirstBrTabGroup taskQueue tasks size equals: 0.
	"System change that should reflected in the Inspector"
	phlowDemo compileFooMethod.
	aSecondPagerPageModel := anInspector pager pages first.
	aSecondPageContentElement := aSecondPagerPageModel widget childNamed: anInspector contentIdentificator.
	aSecondBrTabGroup := self utility compositeViewElementInPagerPageModel: aSecondPagerPageModel.
	"There is a change ready to do."
	self assert: anInspector taskQueue tasks size equals: 0.
	self assert: aSecondBrTabGroup taskQueue tasks size equals: 1.
	"The updated is not done yet. It will happen when the Inspector appears in a Space"
	self assert: aFirstPageContentElement equals: aSecondPageContentElement.
	self assert: aFirstPagerPageModel widget equals: aSecondPagerPageModel widget.
	self assert: aFirstBrTabGroup equals: aSecondBrTabGroup.

	"Let's reinforce the changes"
	aTask := aSecondBrTabGroup taskQueue tasks first.
	aTask action value.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: aFirstPageContentElement equals: aSecondPageContentElement.
	self assert: aFirstBrTabGroup equals: aSecondBrTabGroup.
	"And let's remove the task"
	aSecondBrTabGroup dequeueTask: aTask.
	self assert: aSecondBrTabGroup taskQueue tasks size equals: 0.
	"Let's check the first extension (tab)"
	aSecondTabbar := aSecondBrTabGroup childNamed: #tabbar.
	aSecondTabs := aSecondTabbar children asArray.
	self assert: aFirstTabbar equals: aSecondTabbar.
	self assert: aFirstTabs size + 1 equals: aSecondTabs size.
	self assert: aFirstTabs first ~= aSecondTabs first.
	self assert: aFirstTabs first equals: aSecondTabs second.

	^ anInspector
]

{ #category : #updating }
GtInspectorExamples >> basicInspector [
	<gtExample>
	| anInspector |
	anInspector := GtInspector new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ anInspector
]

{ #category : #updating }
GtInspectorExamples >> changePrintOnMethod [
	<gtExample>
	| anInspector aClass anInstance aFirstPageContentElement aSecondPageContentElement aTask |
	phlowDemo ensurePrintOnMethodRemoved.
	anInspector := self basicInspector.
	aClass := phlowDemo demoClass.
	anInstance := aClass new.
	anInspector spawnInitial: anInstance.
	aFirstPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: anInspector taskQueue tasks size equals: 0.
	"System change that should reflected in the Inspector"
	phlowDemo printOnMethodDefinition.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	"There is a change ready to do."
	self assert: anInspector taskQueue tasks size equals: 1.
	"The updated is not done yet. It will happen when the Inspector appears in a Space"
	self assert: aFirstPageContentElement equals: aSecondPageContentElement.
	
	"Let's reinforce the changes"
	aTask := anInspector taskQueue tasks first.
	aTask action value.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: aFirstPageContentElement ~= aSecondPageContentElement.
	"And let's remove the task"
	anInspector dequeueTask: aTask.
	self assert: anInspector taskQueue tasks size equals: 0.
	
	^ anInspector
]

{ #category : #updating }
GtInspectorExamples >> changePrintOnMethodInSuperclass [
	<gtExample>
	| anInspector aClass anInstance aFirstPageContentElement aSecondPageContentElement aTask |
	phlowDemo ensurePrintOnMethodRemoved.
	anInspector := self basicInspector.
	aClass := phlowDemo demoSubClass.
	anInstance := aClass new.
	anInspector spawnInitial: anInstance.
	aFirstPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: anInspector taskQueue tasks size equals: 0.
	"System change that should reflected in the Inspector"
	phlowDemo printOnMethodDefinition.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	"There is a change ready to do."
	self assert: anInspector taskQueue tasks size equals: 1.
	"The updated is not done yet. It will happen when the Inspector appears in a Space"
	self assert: aFirstPageContentElement equals: aSecondPageContentElement.
	
	"Let's reinforce the changes"
	aTask := anInspector taskQueue tasks first.
	aTask action value.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: aFirstPageContentElement ~= aSecondPageContentElement.
	"And let's remove the task"
	anInspector dequeueTask: aTask.
	self assert: anInspector taskQueue tasks size equals: 0.
	
	^ anInspector
]

{ #category : #updating }
GtInspectorExamples >> demoSubClassInstance [
	<gtExample>
	^ phlowDemo demoSubClass new
]

{ #category : #initialization }
GtInspectorExamples >> initialize [
	super initialize.
	phlowDemo := GtPhlowDemoDefinitionsExamples new.
]

{ #category : #examples }
GtInspectorExamples >> labelViewOfSampleA [
	<gtExample>
	| labelView |
	labelView := self gtViewsFor: GtPhlowEmptyView new..
	self assert: labelView label asString = self printString.
	^ labelView 
]

{ #category : #examples }
GtInspectorExamples >> labelViewOfSmallInteger [
	<gtExample>
	| labelView |
	labelView := 42 gtViewsFor: GtPhlowEmptyView new..
	self assert: labelView label asString = 'a SmallInteger (42)'.
	^ labelView 
]

{ #category : #updating }
GtInspectorExamples >> updateFooViewMethod [
	<gtExample>
	| anInspector aClass anInstance aFirstPageContentElement aSecondPageContentElement aTaskOne aTaskTwo aFirstPagerPageModel aFirstBrTabGroup aSecondPagerPageModel aSecondBrTabGroup aFirstTabbar aFirstTabs aSecondTabbar aSecondTabs |
	phlowDemo ensureFooMethodRemoved.
	phlowDemo ensureBazMethodRemoved.
	anInspector := self addFooViewMethod.
	aClass := phlowDemo demoSubClass.
	anInstance := aClass new.
	anInspector spawnInitial: anInstance.
	aFirstPagerPageModel := anInspector pager pages first.
	aFirstPageContentElement := aFirstPagerPageModel widget childNamed: anInspector contentIdentificator.
	aFirstBrTabGroup := self utility compositeViewElementInPagerPageModel: aFirstPagerPageModel.
	aFirstTabbar := aFirstBrTabGroup childNamed: #tabbar.
	aFirstTabs := aFirstTabbar children asArray.
	self assert: anInspector taskQueue tasks size equals: 0.
	self assert: aFirstBrTabGroup taskQueue tasks size equals: 0.
	"System change that should reflected in the Inspector"
	phlowDemo compileFooMethodVersionTwo.
	aSecondPagerPageModel := anInspector pager pages first.
	aSecondPageContentElement := aSecondPagerPageModel widget childNamed: anInspector contentIdentificator.
	aSecondBrTabGroup := self utility compositeViewElementInPagerPageModel: aSecondPagerPageModel.
	"There is a change ready to do."
	self assert: anInspector taskQueue tasks size equals: 0.
	self assert: aSecondBrTabGroup taskQueue tasks size equals: 2.
	"The updated is not done yet. It will happen when the Inspector appears in a Space"
	self assert: aFirstPageContentElement equals: aSecondPageContentElement.
	self assert: aFirstPagerPageModel widget equals: aSecondPagerPageModel widget.
	self assert: aFirstBrTabGroup equals: aSecondBrTabGroup.

	"Let's reinforce the changes"
	aTaskOne := aSecondBrTabGroup taskQueue tasks first.
	aTaskOne action value.
	aTaskTwo := aSecondBrTabGroup taskQueue tasks second.
	aTaskTwo action value.
	"And let's remove the task"
	aSecondBrTabGroup dequeueTask: aTaskOne.
	aSecondBrTabGroup dequeueTask: aTaskTwo.
	self assert: aSecondBrTabGroup taskQueue tasks size equals: 0.
	aSecondPageContentElement := anInspector pager pages first widget childNamed: anInspector contentIdentificator.
	self assert: aFirstPageContentElement equals: aSecondPageContentElement.
	self assert: aFirstBrTabGroup equals: aSecondBrTabGroup.
	"Let's check the first extension (tab)"
	aSecondTabbar := aSecondBrTabGroup childNamed: #tabbar.
	aSecondTabs := aSecondTabbar children asArray.
	self assert: aFirstTabbar equals: aSecondTabbar.
	self assert: aFirstTabs size equals: aSecondTabs size.
	self assert: aFirstTabs first ~= aSecondTabs first.
	self assert: aFirstTabs second equals: aSecondTabs second.

	^ anInspector
]

{ #category : #examples }
GtInspectorExamples >> viewWithViewsForObject [
	<gtExample>
	| view element |
	view := {1 . 2} gtViewsFor: GtPhlowView empty.
	element := view asElementDo: [ :x | x ].
	self assert: element notNil.
	self assert: (element isKindOf: BlElement).
	^ view
]

{ #category : #examples }
GtInspectorExamples >> viewsOfSampleA [
	<gtExample>
	| views elements |
	views := GtInspectorSampleA new gtViewsInContext: nil.
	self assert: views size equals: 1.
	elements := OrderedCollection new.
	views do: [ :eachView | eachView asElementDo: [ :el | elements add: el ] ].
	self assert: elements size equals: 1.
	^ views
]

{ #category : #examples }
GtInspectorExamples >> viewsOfSampleSubclassOfA [
	<gtExample>
	| inspector compositeViewElement |
	inspector := GtInspector on: self class.
	inspector phlow firstChildWithCompositeViewDo: [ :c |
		c halt ]
]
