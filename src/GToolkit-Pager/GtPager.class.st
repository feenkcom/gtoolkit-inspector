Class {
	#name : #GtPager,
	#superclass : #BrPager,
	#category : #'GToolkit-Pager-UI'
}

{ #category : #'instance creation' }
GtPager class >> createOn: anElement [
	| aPager theElement |
	theElement := anElement asElement.
	self 
		assert: [ theElement viewModel isKindOf: BrPagerPageModel ] 
		description: [ 'The tool element must have ', BrPagerPageModel name asString, ' view model' ].
	aPager := self new.
	aPager 
		matchParent;
		addPage: theElement.
	^ aPager
]

{ #category : #defaults }
GtPager class >> defaultExtent [
	^ 1200@600
]

{ #category : #'private - instance creation' }
GtPager class >> newSpaceWith: anElement title: aTitle [
	| aSpace |
	aSpace := BlSpace new.
	aSpace withHalos.
	aSpace title: aTitle asString.
	aSpace extent: self defaultExtent.
	aSpace root addChild: anElement.
	^ aSpace
]

{ #category : #'instance creation' }
GtPager class >> openOn: anElement [
	^ self openOn: anElement title: 'GToolkit'
]

{ #category : #'instance creation' }
GtPager class >> openOn: anElement title: aTitle [
	| aPager |
	aPager :=  self createOn: anElement.
	self openSpaceWith: aPager title: aTitle.
	^ aPager
]

{ #category : #'instance creation' }
GtPager class >> openOn: anElement title: aTitle from: aSourceElement [
	| aPager |
	aPager :=  self createOn: anElement.
	self openSpaceWith: aPager title: aTitle from: aSourceElement.
	^ aPager
]

{ #category : #'private - instance creation' }
GtPager class >> openSpaceWith: anElement title: aTitle [
	| aSpace |
	aSpace := self newSpaceWith: anElement title: aTitle.
	aSpace show.
	^ aSpace
]

{ #category : #'private - instance creation' }
GtPager class >> openSpaceWith: anElement title: aTitle from: aSourceElement [
	| aSpace |
	aSpace := self newSpaceWith: anElement title: aTitle.
	aSourceElement showSpace: aSpace.
	^ aSpace
]
