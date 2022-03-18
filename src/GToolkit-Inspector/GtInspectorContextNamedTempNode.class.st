Class {
	#name : #GtInspectorContextNamedTempNode,
	#superclass : #GtInspectorVariableNode,
	#instVars : [
		'tempName',
		'tempIndex',
		'tag'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #'instance creation' }
GtInspectorContextNamedTempNode class >> hostObject: aContext tempName: aString tempIndex: anInteger [
	^ (self hostObject: aContext) 
		tempName: aString;
		tempIndex: anInteger;
		variableTag: ((aContext method argumentNames includes: aString)
			ifTrue: [ 'parameter' ]
			ifFalse: [ 'temp' ])
		yourself
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> errorMessage [
	^ 'error obtaining field value'
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> key [
	^ self tempName
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> label [
	^ '[' , self key , ']'
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> rawValue [
	^ self hostObject tempNamed: tempName
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> tempIndex [
	^ tempIndex
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> tempIndex: anObject [
	tempIndex := anObject
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> tempName [
	^ tempName
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> tempName: aString [
	tempName := aString
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> variableTag [
	^ tag ifNil: [ 'temp' ]
]

{ #category : #accessing }
GtInspectorContextNamedTempNode >> variableTag: aTag [
	tag := aTag
]
