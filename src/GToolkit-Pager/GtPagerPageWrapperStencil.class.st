Class {
	#name : #GtPagerPageWrapperStencil,
	#superclass : #BrStencil,
	#instVars : [
		'model',
		'stencil',
		'embellisher'
	],
	#category : #'GToolkit-Pager-Stencils and Builders'
}

{ #category : #private }
GtPagerPageWrapperStencil >> contentIdentificator [
	^ #pageContent
]

{ #category : #'api - instantiation' }
GtPagerPageWrapperStencil >> create [
	<return: #BlElement>
	| anElement aPageModel |

	aPageModel := GtPagerPageModel new.
	aPageModel model: self model.
	self embellisher ifNotNil: [  
		aPageModel embellisher: self embellisher ].

	anElement := GtPagerWrapperElement new
		viewModel: aPageModel;
		clipChildren: false;
		addChild: self stencil asElement as: self contentIdentificator;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	
	^ anElement
]

{ #category : #accessing }
GtPagerPageWrapperStencil >> embellisher [
	^ embellisher
]

{ #category : #accessing }
GtPagerPageWrapperStencil >> embellisher: anObject [
	embellisher := anObject
]

{ #category : #accessing }
GtPagerPageWrapperStencil >> model [
	^ model
]

{ #category : #accessing }
GtPagerPageWrapperStencil >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GtPagerPageWrapperStencil >> stencil [
	^ stencil
]

{ #category : #accessing }
GtPagerPageWrapperStencil >> stencil: anObject [
	stencil := anObject asStencil
]
