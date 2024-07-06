Class {
	#name : #GtVariableBindingsWithVariable,
	#superclass : #Object,
	#instVars : [
		'bindings',
		'variable'
	],
	#category : #'GToolkit-Inspector-Extensions Support'
}

{ #category : #accessing }
GtVariableBindingsWithVariable >> bindings [
	<return: #TGtVariableBindings>
	^ bindings
]

{ #category : #accessing }
GtVariableBindingsWithVariable >> bindings: anObject [
	bindings := anObject
]

{ #category : #accessing }
GtVariableBindingsWithVariable >> name [
	^ self variable name asSymbol printString
]

{ #category : #accessing }
GtVariableBindingsWithVariable >> value [
	^ self bindings
		bindingValueOf: self variable name
		ifPresent: [ :aValue | aValue ]
		ifAbsent: [ 'no value' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
]

{ #category : #accessing }
GtVariableBindingsWithVariable >> variable [
	<return: #Variable>
	^ variable
]

{ #category : #accessing }
GtVariableBindingsWithVariable >> variable: anObject [
	variable := anObject
]
