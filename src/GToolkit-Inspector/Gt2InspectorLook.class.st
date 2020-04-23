Class {
	#name : #Gt2InspectorLook,
	#superclass : #Gt2InspectorProtoLook,
	#traits : 'TGt2InspectorObjectHolderAccess',
	#classTraits : 'TGt2InspectorObjectHolderAccess classTrait',
	#instVars : [
		'objectElementContainter'
	],
	#category : #'GToolkit-Inspector-! New - Look'
}

{ #category : #defaults }
Gt2InspectorLook >> defaultObjectElementContainer [
	^ BrVerticalPane new
		matchParent
]

{ #category : #initialization }
Gt2InspectorLook >> initialize [
	super initialize.
	self initializeObjectHolder.
	objectElementContainter := self defaultObjectElementContainer.
	self addChangeAddChildAs: #(content objectElement) with: [ objectElementContainter ].
]

{ #category : #initialization }
Gt2InspectorLook >> initializeListeners [
	super initializeListeners.
	self 
		when: Gt2InspectorObjectHolderChanged 
		do: [ :anEvent | self onObjectHolderChanged: anEvent ].
]

{ #category : #initialization }
Gt2InspectorLook >> initializeRequests [
	super initializeRequests.
	self request: Gt2InspectorObjectHolderRequest new.
]

{ #category : #convenient }
Gt2InspectorLook >> object [
	^ self objectHolder object
]

{ #category : #hooks }
Gt2InspectorLook >> onObjectHolderChanged: anEvent [
	self objectHolder: anEvent objectHolder.
	self updateView.
]

{ #category : #convenient }
Gt2InspectorLook >> pageView [
	<return: #GtPhlowLabelledView>
	^ self object gtViewsFor: GtPhlowView empty
]

{ #category : #'updating ui' }
Gt2InspectorLook >> updateContentWith: aContentElement [
	"Create and configure an inspector page for a given object and corresponding content element.
	My job is to set up the pager page decorator and configure the neccesary event listeners"

	objectElementContainter 
		removeChildren;
		addChild: aContentElement
]

{ #category : #'updating ui' }
Gt2InspectorLook >> updateView [
	self pageView asElementDo: [ :aPageContentElement |
		self updateContentWith: aPageContentElement ]
]
