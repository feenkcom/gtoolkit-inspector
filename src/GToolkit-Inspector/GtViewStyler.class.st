Class {
	#name : #GtViewStyler,
	#superclass : #GtGenericPharoStyler,
	#instVars : [
		'isGtView',
		'isForward',
		'receiver',
		'object',
		'pragmaSelectors',
		'objectClass',
		'receiverClass'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #private }
GtViewStyler >> assignObjectFromVariable: varName [
	varName asString = 'self'
		ifTrue: [ object := receiver.
			objectClass := receiverClass.
			^ self ].
	receiver
		ifNotNil: [ receiverClass
				slotNamed: varName
				ifFound: [ :slot | self object: (slot read: receiver) ]
				ifNone: [  ] ]
]

{ #category : #private }
GtViewStyler >> gtViewPragmas [
	pragmaSelectors
		ifNil: [ pragmaSelectors := GtPrefixTree new.
			(objectClass
				ifNil: [ Pragma allNamed: #gtView ]
				ifNotNil: [ (GtPhlowViewsCollector new from: objectClass) collectPragmas ])
				do: [ :each | pragmaSelectors add: '#' , each method selector ] ].
	^ pragmaSelectors
]

{ #category : #initialization }
GtViewStyler >> initialize [
	super initialize.
	isGtView := false.
	isForward := false
]

{ #category : #accessing }
GtViewStyler >> object [
	^ object
]

{ #category : #accessing }
GtViewStyler >> object: anObject [
	object := anObject.
	objectClass := anObject class
]

{ #category : #accessing }
GtViewStyler >> objectClass [
	^ objectClass
]

{ #category : #accessing }
GtViewStyler >> objectClass: anObject [
	objectClass := anObject
]

{ #category : #accessing }
GtViewStyler >> receiver [
	^ receiver
]

{ #category : #accessing }
GtViewStyler >> receiver: anObject [
	receiver := anObject.
	receiverClass := anObject class
]

{ #category : #accessing }
GtViewStyler >> receiverClass [
	^ receiverClass
]

{ #category : #accessing }
GtViewStyler >> receiverClass: anObject [
	receiverClass := anObject
]

{ #category : #visiting }
GtViewStyler >> visitMessage: aMessage [
	super visitMessage: aMessage.
	isForward := isForward
			or: [ aMessage selector = #forward
					and: [ aMessage parent receiver = aMessage topParent variables first ] ].
	isForward ifFalse: [ ^ self ].
	(aMessage selector = #object:
		and: [ aMessage arguments first isBlock
				and: [ aMessage arguments first body statements last isVariable ] ])
		ifTrue: [ | varName |
			varName := aMessage arguments first body statements last variableName.
			self assignObjectFromVariable: varName ].
	(aMessage selector = #view:
		and: [ aMessage arguments first isLiteral and: [ aMessage arguments first isSymbol ] ])
		ifTrue: [ self
				attribute: (GtCompletionStrategyAttribute new
						strategy: (GtStringsCompletionStrategy new completions: [ self gtViewPragmas ]))
				from: aMessage arguments first startPosition
				to: aMessage arguments first stopPosition.

			(objectClass notNil
				and: [ (objectClass lookupSelector: aMessage arguments first literalValue) notNil ])
				ifTrue: [ text
						attribute: (GtPharoMethodExpanderAttribute
								forClass: objectClass
								andSelector: aMessage arguments first literalValue)
						from: aMessage arguments first stopPosition
						to: aMessage arguments first stopPosition ] ]
]

{ #category : #visiting }
GtViewStyler >> visitPragma: aPragma [
	isGtView := isGtView or: [ aPragma selector = #gtView ].
	super visitPragma: aPragma
]
