"
I am the main element that represents an inspection context.
"
Class {
	#name : #GtOldInspector,
	#superclass : #BlElement,
	#instVars : [
		'pager',
		'systemListener'
	],
	#classInstVars : [
		'isAutoUpdateEnabled'
	],
	#category : #'GToolkit-Inspector-Brick'
}

{ #category : #ui }
GtOldInspector class >> actionExtensionMethods [
	^ #gtAction pragmas collect: [ :pragma | pragma method asRingDefinition ]
]

{ #category : #cleanup }
GtOldInspector class >> cleanUp [
	self resetIsAutoUpdateEnabled
]

{ #category : #'instance creation' }
GtOldInspector class >> createOn: anObject [
	"create an inspector element on a given object"
	| anInspector |

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector spawnInitial: anObject.

	^ anInspector
]

{ #category : #'instance creation' }
GtOldInspector class >> createOnPlayBook: aPlayBook [
	self 
		deprecated: 'Please use #withToolOn: instead.'
		transformWith: '`@receiver createOnPlayBook: `@statements' -> '`@receiver withToolOn: `@statements'.
	^ self withToolOn: aPlayBook
]

{ #category : #private }
GtOldInspector class >> createSpaceWith: anElement title: aTitleString [
	| aSpace |
	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace title: aTitleString.
	aSpace extent: 1200 @ 600.
	aSpace root addChild: anElement.
	^ aSpace
]

{ #category : #settings }
GtOldInspector class >> disableAutoUpdate [
	<script>
	isAutoUpdateEnabled := false
]

{ #category : #settings }
GtOldInspector class >> enableAutoUpdate [
	<script>
	isAutoUpdateEnabled := true
]

{ #category : #ui }
GtOldInspector class >> gtActionsFor: aView [
	<gtView>
	^ (#gtAction gtPragmas gtItemsFor: aView)
		title: 'Actions';
		priority: 1
]

{ #category : #ui }
GtOldInspector class >> gtExtensionsFor: aView [
	<gtView>
	^ (#gtView gtPragmas gtItemsFor: aView)
		title: 'Extensions';
		priority: 0
]

{ #category : #settings }
GtOldInspector class >> isAutoUpdateEnabled [
	^ isAutoUpdateEnabled ifNil: [ isAutoUpdateEnabled := true ]
]

{ #category : #testing }
GtOldInspector class >> isDeprecated [ 
	^ true
]

{ #category : #'instance creation' }
GtOldInspector class >> openOn: anObject [
	| anInspector aSpace |

	anInspector :=  self createOn: anObject.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace title: 'Inspector'.
	aSpace extent: 1200@600.
	aSpace root addChild: anInspector.
	aSpace show.

	^ anInspector
]

{ #category : #'instance creation' }
GtOldInspector class >> openOn: anObject from: anElement [
	| anInspector aSpace |

	anInspector :=  self createOn: anObject.
	aSpace := self createSpaceWith: anInspector title: 'Inspector'.	
	anElement showSpace: aSpace.

	^ anInspector
]

{ #category : #'instance creation' }
GtOldInspector class >> openOn: anAsElementObject title: aWindowTitle [
	| anInspector aSpace |

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector addPageWithContent: anAsElementObject asElement for: anAsElementObject.

	aSpace := self createSpaceWith: anInspector title: aWindowTitle.
	aSpace show.

	^ anInspector
]

{ #category : #'instance creation' }
GtOldInspector class >> openOnPlayBook: aPlayBook [
	^ self openToolOn: aPlayBook named: 'Playground'
]

{ #category : #'instance creation' }
GtOldInspector class >> openOnPlayBook: aPlayBook from: anElement [
	^ self openToolOn: aPlayBook named: 'Playground' from: anElement
]

{ #category : #'instance creation' }
GtOldInspector class >> openToolOn: anObject named: aString [
	| anInspector aSpace |
	anInspector := self withToolOn: anObject.
	aSpace := self createSpaceWith: anInspector title: aString.
	aSpace show.
	^ anInspector
]

{ #category : #'instance creation' }
GtOldInspector class >> openToolOn: anObject named: aString from: anElement [
	| anInspector aSpace |
	anInspector := self withToolOn: anObject.
	aSpace := self createSpaceWith: anInspector title: aString.
	anElement showSpace: aSpace.
	^ anInspector
]

{ #category : #cleanup }
GtOldInspector class >> resetIsAutoUpdateEnabled [
	isAutoUpdateEnabled := nil
]

{ #category : #ui }
GtOldInspector class >> viewExtensionMethods [
	^ #gtView pragmas collect: [ :pragma | pragma method asRingDefinition ]
]

{ #category : #'instance creation' }
GtOldInspector class >> withToolOn: anObject [
	"It receives an object that understands #asElement"
	<return: #GtOldInspector>
	| anInspector |

	self 
		assert: [ anObject respondsTo: #asElement ]
		description: [ 'Object must responds to #asElement' ].

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector addPageWithContent: anObject asElement for: anObject.

	^ anInspector
]

{ #category : #private }
GtOldInspector >> addPageWithContent: aContentElement for: anObject [
	| page |
	page := self createPageWithContent: aContentElement for: anObject.
	systemListener addClass: anObject class instanceSide.
	pager addPage: page.
	^ page
]

{ #category : #'api - inspector' }
GtOldInspector >> close: aPageElement [
	pager removePage: aPageElement
]

{ #category : #private }
GtOldInspector >> computePageWeightFor: anObject [
	"Compute the proportion of the page within the inspector.
	The returned number should be a float [0...1].
	For example 0.5 means that the page will take 50% of the inspector's width"
	<return: #Number>

	^ self defaultPageWeight
]

{ #category : #private }
GtOldInspector >> computePageWidthFor: anObject [
	"The width is recorded when user explicitely resizes the page, it is then later
	used while inspecting an object of that same type.
	If there is no recorded width, inspector takes the width of a previous page if one exists
	or falls back to the default width"
	<return: #Number>

	^ self defaultPageWidth
]

{ #category : #private }
GtOldInspector >> contentIdentificator [
	^ #pageContent
]

{ #category : #private }
GtOldInspector >> createPageWithContent: aContentElement for: anObject [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"
	| aPageModel aPageEmbellisher aPageElement |

	"width should depend on anObject"
	aPageEmbellisher := GtInspectorPagerPageEmbellisher new.
	aPageEmbellisher inspector: self.
	aPageEmbellisher beMatching: (self computePageWeightFor: anObject).

	aPageModel := BrPagerPageModel new.
	aPageModel model: anObject.
	aPageModel embellisher: aPageEmbellisher.

	aPageElement := BlElement new
		viewModel: aPageModel;
		clipChildren: false;
		addChild: aContentElement as: self contentIdentificator;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	^ aPageElement
]

{ #category : #initialization }
GtOldInspector >> defaultPageWeight [
	^ 0.5
]

{ #category : #initialization }
GtOldInspector >> defaultPageWidth [
	^ 400
]

{ #category : #private }
GtOldInspector >> findPageContaining: anElement ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	<return: #BlElement>
	
	anElement withAllParentsDo: [ :eachParentElement |
		(eachParentElement viewModel isNotNil and: [
			(pager viewModel pages includes: eachParentElement viewModel) ])
				ifTrue: [ ^ aPresentBlock  value: eachParentElement ] ].
			
	^ anAbsentBlock value
]

{ #category : #initialization }
GtOldInspector >> initialize [
	super initialize.

	pager := BrPager new.
	pager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: pager.
	systemListener := GtInspectorSystemChangesHandler new inspector: self
]

{ #category : #testing }
GtOldInspector >> isAutoUpdateEnabled [
	^ self class isAutoUpdateEnabled
]

{ #category : #private }
GtOldInspector >> pageViewFor: aSelectedObject [
	<return: #GtPhlowLabelledView>
	^ aSelectedObject gtViewsFor: GtPhlowView empty
]

{ #category : #private }
GtOldInspector >> pager [
	^ pager
]

{ #category : #private }
GtOldInspector >> replaceContent: aBrTabGroup atPage: aBlElement [ 
	| aCurrentChild |
	aCurrentChild := aBlElement childNamed: self contentIdentificator ifFound: [ :el | el ] ifNone: [ ^ self ].
	aBlElement replaceChild: aCurrentChild with: aBrTabGroup as: self contentIdentificator.
]

{ #category : #'api - inspector' }
GtOldInspector >> select: aSelectedObject after: aPageElement [
	(pager hasPageAfter: aPageElement) ifTrue: [
		self spawn: aSelectedObject after: aPageElement ]
]

{ #category : #'api - inspector' }
GtOldInspector >> selectDueTo: anEvent [

	self
		findPageContaining: anEvent sourceElement
		ifPresent: [ :aPageElement | self select: anEvent object after: aPageElement ]
		ifAbsent: [ ]
]

{ #category : #private }
GtOldInspector >> selectTabNamed: aPreferredSelectedTabTitle inPage: newPage [
	^ newPage phlow
		firstChildWithCompositeViewDo: [ :tabGroup | 
			tabGroup viewModel tabs
				detect:
					[ :tabModel | 
						| aTitle |
						aTitle := tabModel widget phlow entity ifNotNil: #title.
						aTitle = aPreferredSelectedTabTitle ]
				ifFound: [ :tabModel | tabModel select ] ]
]

{ #category : #private }
GtOldInspector >> selectedTabNameInPage: aPageElement [
	<return: #String or: nil>
	| aPreferredSelectedTabTitle |
	aPreferredSelectedTabTitle := nil.
	aPageElement phlow
				firstChildWithCompositeViewDo: [ :tabGroup | 
					aPreferredSelectedTabTitle := tabGroup viewModel selectedTab widget
						phlow entity ifNotNil: #title ].
	^ aPreferredSelectedTabTitle
]

{ #category : #private }
GtOldInspector >> selectedTabNameInPageAfter: aPageElement [
	<return: #String or: nil>
	| aPreferredSelectedTabTitle |
	aPreferredSelectedTabTitle := nil.
	pager
		pageAfter: aPageElement
		ifFound: [ :aNextPageModel | 
			aPreferredSelectedTabTitle := self selectedTabNameInPage: aNextPageModel widget ]
		ifNone: [  ].
	^ aPreferredSelectedTabTitle
]

{ #category : #'api - inspector' }
GtOldInspector >> spawn: aSelectedObject after: aPageElement [
	| aPageView |
	aPageView := self pageViewFor: aSelectedObject.
	aPageView
		asElementDo: [ :aViewElement | 
			| aPreferredSelectedTabTitle aNewPage |
			aPreferredSelectedTabTitle := self selectedTabNameInPageAfter: aPageElement.
			pager removePagesAfter: aPageElement.
			aNewPage := self addPageWithContent: aViewElement for: aSelectedObject.
			self selectTabNamed: aPreferredSelectedTabTitle inPage: aNewPage.
			pager smoothScrollToLast ]
]

{ #category : #'api - inspector' }
GtOldInspector >> spawnDueTo: anEvent [

	self
		findPageContaining: anEvent sourceElement
		ifPresent: [ :aPageElement | self spawn: anEvent object after: aPageElement ]
		ifAbsent: [ 	]
]

{ #category : #'api - inspector' }
GtOldInspector >> spawnInitial: aSelectedObject [
	| aPageView |

	aPageView := self pageViewFor: aSelectedObject.
	aPageView asElementDo: [ :aPageContentElement |
		self addPageWithContent: aPageContentElement for: aSelectedObject ]
]

{ #category : #subscriptions }
GtOldInspector >> unsubscribeFromSystem [
	systemListener unsubscribeFromSystem
]

{ #category : #private }
GtOldInspector >> updatePageModelWidget: aBrPagerPageModel [ 
	| aSelectedObject aPageView |
	self 
		assert: [ aBrPagerPageModel widget notNil ]
		description: [ 'I believe that aBrPagerPageModel widget must be non-nil :-)' ].
	self isAutoUpdateEnabled ifFalse: [ ^ self ].
	aSelectedObject := aBrPagerPageModel model.
	aPageView := self pageViewFor: aSelectedObject.
	aPageView asElementDo: [ :aViewElement | 
			| aPreferredSelectedTabTitle |
			aPreferredSelectedTabTitle := self selectedTabNameInPage: aBrPagerPageModel widget.
			self selectTabNamed: aPreferredSelectedTabTitle inPage: aViewElement.
			self replaceContent: aViewElement atPage: aBrPagerPageModel widget ]
]
