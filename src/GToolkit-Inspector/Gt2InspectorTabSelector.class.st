Class {
	#name : #Gt2InspectorTabSelector,
	#superclass : #Gt2InspectorTabProtoSelector,
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #testing }
Gt2InspectorTabSelector class >> isAbstract [
	^ self name = #Gt2InspectorTabSelector 
]

{ #category : #factory }
Gt2InspectorTabSelector class >> simple [
	^ Gt2InspectorTabSimpleSelector new
]
