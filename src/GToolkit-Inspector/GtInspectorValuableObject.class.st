Class {
	#name : #GtInspectorValuableObject,
	#superclass : #GtInspectorAbstractObject,
	#instVars : [
		'viewSelector',
		'cache',
		'valuable',
		'hasValuable'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #converting }
GtInspectorValuableObject >> asElementDo: aOneArgBlock [
	"Create an element representing an object and execute the block"

	^ BrFrame new
		matchParent;
		withAsyncFutureDo: [ :anElementFuture | 
			anElementFuture
				whenPending: [ :theContainer | 
					theContainer removeChildren ];
				whenError: [ :theContainer :anError | 
					theContainer
						removeChildren;
						addChild: anError asDebuggableElement ];
				whenSuccess: [ :theContainer :aView | 
					theContainer
						removeChildren;
						addChild: (aView asElementDo: #yourself) ].
						
			anElementFuture future: ((self future 
				map: (MessageSend 
					receiver: self 
					selector: #viewFor:))) ];
		in: [ :theFrame | aOneArgBlock cull: theFrame ]
]

{ #category : #asserting }
GtInspectorValuableObject >> assertValuableImmutability [
	self 
		assert: [ hasValuable not ]
		description: [ 'Object holder is immutable. The object cannot be changed.' ].
]

{ #category : #asserting }
GtInspectorValuableObject >> assertViewSelectorImmutability [
	self 
		assert: [ self viewSelector = self defaultViewSelector ]
		description: [ 'Object holder is immutable. The view selector cannot be changed.' ].
]

{ #category : #defaults }
GtInspectorValuableObject >> defaultViewSelector [
	^ #gtViewsFor:
]

{ #category : #'api - future' }
GtInspectorValuableObject >> future [
	^ AsyncCachedFuture 
		forFuture: valuable asAsyncFuture flatten
		cache: cache
]

{ #category : #initialization }
GtInspectorValuableObject >> initialize [
	super initialize.
	viewSelector := self defaultViewSelector.
	cache := AsyncFutureCache new.
	hasValuable := false
]

{ #category : #accessing }
GtInspectorValuableObject >> object [
	^ cache 
		ifSome: #yourself 
		ifNone: [ nil ]
]

{ #category : #printing }
GtInspectorValuableObject >> printOn: aStream [
	aStream 
		nextPutAll: 'Future holder of ';
		print: valuable
]

{ #category : #'api - initialization' }
GtInspectorValuableObject >> valuable: aValuable [
	self assertValuableImmutability.
	self 
		assert: [ aValuable isAsyncFuture not ] 
		description: [ 'Do not pass futures as the computation may be triggered couple of times' ].
	
	valuable := aValuable.
	hasValuable := true
]

{ #category : #'private - computing' }
GtInspectorValuableObject >> viewFor: anObject [
	"Answer the view for the receiver's object and view"

	<return: #GtPhlowLabelledView>
	^ GtPhlowView empty on: anObject perform: self viewSelector
]

{ #category : #accessing }
GtInspectorValuableObject >> viewSelector [
	<return: #Symbol>
	^ viewSelector
]

{ #category : #accessing }
GtInspectorValuableObject >> viewSelector: aSymbol [
	self assertViewSelectorImmutability.
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'View selector must be a symbol' ].
	viewSelector := aSymbol asSymbol 
]
