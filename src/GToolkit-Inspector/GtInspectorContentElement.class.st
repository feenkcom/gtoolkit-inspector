"
I display an object graphical representation.
I use {{gtMethod:GtInspectorObject>>#asElementDo:}} to generate the object inspector widget.

{{gtExample:GtInspectorExamples>>#contentElement|previewExpanded}}


"
Class {
	#name : #GtInspectorContentElement,
	#superclass : #GtInspectorObjectElement,
	#category : #'GToolkit-Inspector-UI'
}

{ #category : #initialization }
GtInspectorContentElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self updateView.
	self addAptitude: BrLayoutResizerAptitude inherit.
]

{ #category : #'private - hooks' }
GtInspectorContentElement >> onObjectHolderChanged [
	super onObjectHolderChanged.
	self updateView.
]

{ #category : #'private - updating' }
GtInspectorContentElement >> updateContentWith: aContentElement [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"

	self 
		removeChildren;
		addChild: aContentElement
]

{ #category : #'private - updating' }
GtInspectorContentElement >> updateView [
	self objectHolder asElementDo: [ :aPageContentElement |
		self updateContentWith: aPageContentElement ]
]
