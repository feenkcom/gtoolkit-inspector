Class {
	#name : #GtInspectorElementFocusabilityAndFocusOverview,
	#superclass : #Object,
	#instVars : [
		'inspectedElement'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> allFocusableChildren [
	^ self allFocusableChildrenFor: inspectedElement
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> allFocusableChildrenFor: anElement [
	| aList |
	anElement ifNil: [ ^ #() ].

	aList := LinkedList new.

	self
		element: anElement
		breadthFirstDo: [ :aChild | aChild isFocusable ifTrue: [ aList add: aChild ] ]
		enqueueChildrenIf: [ :aChild | true ].

	^ aList
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> element: anElement breadthFirstDo: aDoBlock enqueueChildrenIf: aConditionBlock [
	| queue |
	queue := LinkedList withAll: anElement children.
	[ queue notEmpty ] whileTrue: [ 
		| child |
		child := queue removeFirst.
		aDoBlock value: child.
		(aConditionBlock value: child) 
			ifTrue: [ queue addAll: child children ] 
	]
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> elementFocusability [
	^ inspectedElement focusability
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> elementHasFocus [
	^ inspectedElement hasFocus
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> elementHasFocusable [
	^ inspectedElement hasFocusable
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> elementIsFocusable [
	^ inspectedElement isFocusable
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> elementIsFocused [
	^ inspectedElement isFocused
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> focusableChildren [
	^ self focusableChildrenFor: inspectedElement
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> focusableChildrenFor: anElement [
	| aList |
	anElement ifNil: [ ^ #() ].

	aList := LinkedList new.

	self
		element: anElement
		breadthFirstDo: [ :aChild | aChild isFocusable ifTrue: [ aList add: aChild ] ]
		enqueueChildrenIf: [ :aChild | aChild isFocusable not ].

	^ aList
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> focusedChildren [
	| aList |
	inspectedElement ifNil: [ ^ #() ].

	aList := LinkedList new.

	inspectedElement
		allChildrenBreadthFirstDo: [ :aChild | aChild isFocused ifTrue: [ aList add: aChild ] ].

	^ aList
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> focusedChildrenFor: anElement [
	| aList |
	anElement ifNil: [ ^ #() ].

	aList := LinkedList new.
	
	self
		element: anElement
		breadthFirstDo: [ :aChild | aChild isFocused ifTrue: [ aList add: aChild ] ]
		enqueueChildrenIf: [ :aChild | aChild isFocused not ].

	^ aList
]

{ #category : #'gt - extensions' }
GtInspectorElementFocusabilityAndFocusOverview >> gtFocusabilityChildrenFor: aView [
	<gtView>
	self inspectedElement ifNil: [ ^ aView empty ].

	^ aView columnedTree
		title: 'Focusable children';
		priority: 10;
		items: [ self focusableChildren ];
		children: [ :anElement | self focusableChildrenFor: anElement ];
		column: 'Preview'
			do: [ :aColumn | aColumn
				stencil: [ :eachElement | 
					eachElement gtPreviewThumbnailFor: eachElement ] ];
		column: 'Type' text: [ :eachElement | eachElement class ];
		column: 'Element' text: [ :anElement | (anElement containerName ifNil: [''] ifNotNil: [ :aContainerName | '#',aContainerName, ' ' ]), anElement asString ];
		column: 'Composition layer'
			text: [ :eachElement | 
				eachElement wantsSeparateCompositingLayer
					ifTrue: [ 'Yes' ]
					ifFalse: [ '' ] ]
			width: 100
]

{ #category : #'gt - extensions' }
GtInspectorElementFocusabilityAndFocusOverview >> gtFocusedChildrenFor: aView [
	<gtView>
	self inspectedElement ifNil: [ ^ aView empty ].

	^ aView columnedTree
		title: 'Focused children';
		priority: 5;
		items: [ self focusedChildren ];
		children: [ :anElement | self focusedChildrenFor: anElement ];
		column: 'Preview'
			do: [ :aColumn | aColumn
				stencil: [ :eachElement | 
					eachElement gtPreviewThumbnailFor: eachElement ] ];
		column: 'Type' text: [ :eachElement | eachElement class ];
		column: 'Element' text: [ :anElement | (anElement containerName ifNil: [''] ifNotNil: [ :aContainerName | '#',aContainerName, ' ' ]), anElement asString ];
		column: 'Composition layer'
			text: [ :eachElement | 
				eachElement wantsSeparateCompositingLayer
					ifTrue: [ 'Yes' ]
					ifFalse: [ '' ] ]
			width: 100
]

{ #category : #'gt - extensions' }
GtInspectorElementFocusabilityAndFocusOverview >> gtOverviewDictionary [
	^ OrderedDictionary new 
		at: 'Is focusable' put: self elementIsFocusable;
		at: 'Has focusable' put: self elementHasFocusable;
		at: 'Number of focusable children (excluding sub-children)' put: self focusableChildren size;
		at: 'Number of all focusable children (including sub-children)' put: self allFocusableChildren size;
		at: 'Focusability' put: self elementFocusability;
		at: 'Is focused' put: self elementIsFocused;
		at: 'Has focus' put: self elementHasFocus;
		at: 'Number of focused children' put: self focusedChildren size;
		yourself
		
]

{ #category : #'gt - extensions' }
GtInspectorElementFocusabilityAndFocusOverview >> gtOverviewFor: aView [
	<gtView>
	self inspectedElement ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		priority: 1;
		items: [ self gtOverviewDictionary associations ];
		column: 'Name' text: [ :anAssoc | anAssoc key ];
		column: 'Value' text: [ :anAssoc | anAssoc value ];
		send: #value
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> inspectedElement [
	^ inspectedElement
]

{ #category : #accessing }
GtInspectorElementFocusabilityAndFocusOverview >> inspectedElement: anObject [
	inspectedElement := anObject
]
