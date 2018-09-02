Class {
	#name : #GtInspector,
	#superclass : #BlElement,
	#instVars : [
		'pager'
	],
	#classVars : [
		'PageWidthPerClass'
	],
	#category : 'GToolkit-Inspector'
}

{ #category : #initialization }
GtInspector class >> initialize [
	super initialize.
	
	PageWidthPerClass := Dictionary new
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
	^ self openOnPlayBook: GtPlayBook new
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
GtInspector >> computePageWidthFor: anObject [
	"The width is recorded when user explicitely resizes the page, it is then later
	used while inspecting an object of that same type.
	If there is no recorded width, inspector takes the width of a previous page if one exists
	or falls back to the default width"
	<return: #Number>

	^ PageWidthPerClass
		at: anObject class
		ifAbsent: [ pager pages
			ifEmpty: [ self defaultPageWidth ]
			ifNotEmpty: [ pager pages last embellisher width ] ]
]

{ #category : #private }
GtInspector >> createPageWithContent: aContentElement for: anObject [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"
	| aPageModel aPageEmbellisher aPageElement |

	"width should depend on anObject"
	aPageEmbellisher := GtInspectorPagerPageEmbellisher new.
	aPageEmbellisher inspector: self.
	aPageEmbellisher width: (self computePageWidthFor: anObject).
	aPageEmbellisher whenResizedDo: [ :anExtent | self recordPageWidth: anExtent x for: anObject ].

	aPageModel := BrPagerPageModel new.
	aPageModel model: anObject.
	aPageModel embellisher: aPageEmbellisher.

	aPageElement := BlElement new
		viewModel: aPageModel;
		addChild: aContentElement;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	^ aPageElement
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

{ #category : #'private - pages' }
GtInspector >> isLastPage: aPageContentElement [
]

{ #category : #private }
GtInspector >> pager [
	^ pager
]

{ #category : #private }
GtInspector >> recordPageWidth: aNumber for: anObject [
	PageWidthPerClass at: anObject class put: aNumber
]

{ #category : #'api - inspector' }
GtInspector >> select: aSelectedObject after: aPageElement [
	(pager hasPageAfter: aPageElement) ifTrue: [
		self spawn: aSelectedObject after: aPageElement ]
]

{ #category : #'api - inspector' }
GtInspector >> selectDueTo: anEvent [
	| aSourceElement |
	
	aSourceElement := anEvent sourceElement.
	
	self
		findPageContaining: aSourceElement
		ifPresent: [ :aPageElement |
			| aSelectedObject |
			
			aSelectedObject := anEvent object.
			
		]
		ifAbsent: [ ].
]

{ #category : #'api - inspector' }
GtInspector >> spawn: aSelectedObject after: aPageElement [
	| aPageView |
	aPageView := aSelectedObject gtViewsFor: GtPhlowEmptyView new.
	aPageView asElementDo: [ :aViewElement |
		| preferredSelectedTabTitle newPage |
		preferredSelectedTabTitle := nil.
		pager 
			pageAfter: aPageElement
			ifFound: [ :aNextPageModel |
				aNextPageModel widget 
					allChildrenBreadthFirstDetect: [ :each | each phlow isView ]
					ifFound: [ :first |
						first parentTabGroup content 
							allChildrenBreadthFirstDetect: [ :each | each phlow isView ]
							ifFound: [ :tab | 
								preferredSelectedTabTitle := tab parentTabGroup viewModel selectedTab widget phlow entity title ] ] ] 
			ifNone: [ ].
		pager removePagesAfter: aPageElement.
		newPage := self addPageWithContent: aViewElement for: aSelectedObject.
		newPage 
			allChildrenBreadthFirstDetect: [ :each | each phlow isView ]
			ifFound: [ :first | 
				first parentTabGroup content 
					allChildrenBreadthFirstDetect: [ :each | each phlow isView ]
					ifFound: [ :tab | 
						tab parentTabGroup viewModel tabs 
							detect: [ :tabModel | tabModel widget phlow entity title = preferredSelectedTabTitle ]
							ifFound: [ :tabModel | tabModel select ] ] ] ]
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

	aPageView := aSelectedObject gtViewsFor: GtPhlowEmptyView new.
	aPageView asElementDo: [ :aPageContentElement |
		self addPageWithContent: aPageContentElement for: aSelectedObject ]
]
