Class {
	#name : #GtTestObjectForViewCreation,
	#superclass : #Object,
	#instVars : [
		'listOfAssociations',
		'stringValue',
		'pluggableValue',
		'dictionaryOfCollections'
	],
	#category : #'GToolkit-Inspector-Example Samples'
}

{ #category : #accessing }
GtTestObjectForViewCreation >> dictionaryOfCollections [
	^ dictionaryOfCollections
]

{ #category : #accessing }
GtTestObjectForViewCreation >> dictionaryOfCollections: aDictionary [ 
	dictionaryOfCollections := aDictionary 
]

{ #category : #accessing }
GtTestObjectForViewCreation >> groupedByKey [
	^ (listOfAssociations groupedBy: [ :each | each key ])
]

{ #category : #initialization }
GtTestObjectForViewCreation >> initialize [
	super initialize.
	
	stringValue := 'Hello world'.
	listOfAssociations := ((1 to: 3) collect: [ :each | 'ProjectA' -> each]),
		((1 to: 10) collect: [ :each | 'ProjectB' -> each]),
		((1 to: 5) collect: [ :each | 'ProjectC' -> each]).
	dictionaryOfCollections := self groupedByKey.
]

{ #category : #accessing }
GtTestObjectForViewCreation >> listOfAssociations [
	^ listOfAssociations
]

{ #category : #accessing }
GtTestObjectForViewCreation >> listOfAssociations: aListOfAssociations [
	listOfAssociations := aListOfAssociations
]

{ #category : #accessing }
GtTestObjectForViewCreation >> pluggableValue [
	^ pluggableValue
]

{ #category : #accessing }
GtTestObjectForViewCreation >> pluggableValue: anObject [
	pluggableValue := anObject
]

{ #category : #accessing }
GtTestObjectForViewCreation >> stringValue [
	^ stringValue
]

{ #category : #accessing }
GtTestObjectForViewCreation >> stringValue: aString [
	stringValue := aString
]
