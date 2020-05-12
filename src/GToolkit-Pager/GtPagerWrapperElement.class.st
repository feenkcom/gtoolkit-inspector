Class {
	#name : #GtPagerWrapperElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Pager-UI'
}

{ #category : #accessing }
GtPagerWrapperElement >> embellisher: aStencil [
	self viewModel embellisher: aStencil
]

{ #category : #initialization }
GtPagerWrapperElement >> initialize [
	super initialize.
	self initializeViewModel.
	self initializeElement.
]

{ #category : #initialization }
GtPagerWrapperElement >> initializeElement [
	self 
		clipChildren: false;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
]

{ #category : #initialization }
GtPagerWrapperElement >> initializeViewModel [
	self viewModel: GtPagerPageModel new
]

{ #category : #accessing }
GtPagerWrapperElement >> model: anObject [
	self viewModel model: anObject
]

{ #category : #accessing }
GtPagerWrapperElement >> stencil: aStencil [
	self tool: aStencil asElement
]

{ #category : #accessing }
GtPagerWrapperElement >> tool [
	<return: #BlElement>
	^ self childNamed: self toolIdentificator.
]

{ #category : #accessing }
GtPagerWrapperElement >> tool: anElement [
	<return: #BlElement>
	^ self addChild: anElement as: self toolIdentificator.
]

{ #category : #accessing }
GtPagerWrapperElement >> toolIdentificator [
	^ #tool
]
