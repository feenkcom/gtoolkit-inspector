"
I am the main element that represents an inspection context.
"
Class {
	#name : #GtInspector,
	#superclass : #BlElement,
	#instVars : [
		'pager'
	],
	#category : #'GToolkit-Inspector'
}

{ #category : #ui }
GtInspector class >> actionExtensionMethods [
	^ #gtAction pragmas collect: [ :pragma | pragma method asRingDefinition ]
]

{ #category : #ui }
GtInspector class >> gtActionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Actions';
		priority: 30;
		stencil: [
			| list |
			list := BrColumnedList new display: self actionExtensionMethods.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			list column
				title: 'Package';
				stencil: [ :aMethod :index | 
					| textElement text |
					text := aMethod method package name asRopedText.								
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list column
				title: 'Class';
				stencil: [ :aMethod :index | 
					| textElement text |
					text := aMethod methodClass name asRopedText.								
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list column
				title: 'Selector';
				stencil: [ :aMethod :index |
					| text textElement |
					text := aMethod selector asRopedText.
					textElement := (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ].
			  ].
			list]
]

{ #category : #ui }
GtInspector class >> gtExtensionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Extensions';
		priority: 20;
		stencil: [
			| list |
			list := BrColumnedList new display: self viewExtensionMethods.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			list column
				title: 'Package';
				stencil: [ :aMethod :index | 
					| textElement text |
					text := aMethod method package name asRopedText.								
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list column
				title: 'Class';
				stencil: [ :aMethod :index | 
					| textElement text |
					text := aMethod methodClass name asRopedText.								
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list column
				title: 'Selector';
				stencil: [ :aMethod :index |
					| text textElement |
					text := aMethod selector asRopedText.
					textElement := (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ].
			  ].
			list]
]

{ #category : #'instance creation' }
GtInspector class >> openOn: anObject [
	| anInspector aSpace |

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector spawnInitial: anObject.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace title: 'Inspector'.
	aSpace extent: 1200@600.
	aSpace root addChild: anInspector.
	aSpace show.

	^ anInspector
]

{ #category : #'instance creation' }
GtInspector class >> openOnPlayBook [
	^ self openOnPlayBook: GtPlayBook newDefault
]

{ #category : #'instance creation' }
GtInspector class >> openOnPlayBook: aPlayBook [
	| anInspector aSpace |

	anInspector := self new.
	anInspector constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	anInspector addPageWithContent: aPlayBook asElement for: aPlayBook.

	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace title: 'Playground'.
	aSpace extent: 1200@600.
	aSpace root addChild: anInspector.
	aSpace show.

	^ anInspector
]

{ #category : #ui }
GtInspector class >> viewExtensionMethods [
	^ #gtView pragmas collect: [ :pragma | pragma method asRingDefinition ]
]

{ #category : #private }
GtInspector >> addPageWithContent: aContentElement for: anObject [
	| page |
	page := self createPageWithContent: aContentElement for: anObject.
	pager addPage: page.
	^ page
]

{ #category : #'api - inspector' }
GtInspector >> close: aPageElement [
	pager removePage: aPageElement
]

{ #category : #private }
GtInspector >> computePageWeightFor: anObject [
	"Compute the proportion of the page within the inspector.
	The returned number should be a float [0...1].
	For example 0.5 means that the page will take 50% of the inspector's width"
	<return: #Number>

	^ self defaultPageWeight
]

{ #category : #private }
GtInspector >> computePageWidthFor: anObject [
	"The width is recorded when user explicitely resizes the page, it is then later
	used while inspecting an object of that same type.
	If there is no recorded width, inspector takes the width of a previous page if one exists
	or falls back to the default width"
	<return: #Number>

	^ self defaultPageWidth
]

{ #category : #private }
GtInspector >> createPageWithContent: aContentElement for: anObject [
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
		addChild: aContentElement;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	^ aPageElement
]

{ #category : #initialization }
GtInspector >> defaultPageWeight [
	^ 0.5
]

{ #category : #initialization }
GtInspector >> defaultPageWidth [
	^ 400
]

{ #category : #private }
GtInspector >> findPageContaining: anElement ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	<return: #BlElement>
	
	anElement withAllParentsDo: [ :eachParentElement |
		(eachParentElement viewModel isNotNil and: [
			(pager viewModel pages includes: eachParentElement viewModel) ])
				ifTrue: [ ^ aPresentBlock  value: eachParentElement ] ].
			
	^ anAbsentBlock value
]

{ #category : #initialization }
GtInspector >> initialize [
	super initialize.

	pager := BrPager new.
	pager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: pager.
]

{ #category : #private }
GtInspector >> isLastPage: aPageContentElement [
]

{ #category : #private }
GtInspector >> pageViewFor: aSelectedObject [
	<return: #GtPhlowLabelledView>
	^ aSelectedObject gtViewsFor: GtPhlowView empty
]

{ #category : #private }
GtInspector >> pager [
	^ pager
]

{ #category : #'api - inspector' }
GtInspector >> select: aSelectedObject after: aPageElement [
	(pager hasPageAfter: aPageElement) ifTrue: [
		self spawn: aSelectedObject after: aPageElement ]
]

{ #category : #'api - inspector' }
GtInspector >> selectDueTo: anEvent [

	self
		findPageContaining: anEvent sourceElement
		ifPresent: [ :aPageElement | self select: anEvent object after: aPageElement ]
		ifAbsent: [ ]
]

{ #category : #private }
GtInspector >> selectTabNamed: aPreferredSelectedTabTitle inPage: newPage [
	^ newPage phlow
		firstChildWithCompositeViewDo: [ :tabGroup | 
			tabGroup viewModel tabs
				detect:
					[ :tabModel | tabModel widget phlow entity title = aPreferredSelectedTabTitle ]
				ifFound: [ :tabModel | tabModel select ] ]
]

{ #category : #private }
GtInspector >> selectedTabNameInPageAfter: aPageElement [
	<return: #String or: nil>
	| aPreferredSelectedTabTitle |
	aPreferredSelectedTabTitle := nil.
	pager
		pageAfter: aPageElement
		ifFound: [ :aNextPageModel | 
			aNextPageModel widget phlow
				firstChildWithCompositeViewDo: [ :tabGroup | 
					aPreferredSelectedTabTitle := tabGroup viewModel selectedTab widget
						phlow entity title ] ]
		ifNone: [  ].
	^ aPreferredSelectedTabTitle
]

{ #category : #'api - inspector' }
GtInspector >> spawn: aSelectedObject after: aPageElement [
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
GtInspector >> spawnDueTo: anEvent [

	self
		findPageContaining: anEvent sourceElement
		ifPresent: [ :aPageElement | self spawn: anEvent object after: aPageElement ]
		ifAbsent: [ 	]
]

{ #category : #'api - inspector' }
GtInspector >> spawnInitial: aSelectedObject [
	| aPageView |

	aPageView := self pageViewFor: aSelectedObject.
	aPageView asElementDo: [ :aPageContentElement |
		self addPageWithContent: aPageContentElement for: aSelectedObject ]
]
