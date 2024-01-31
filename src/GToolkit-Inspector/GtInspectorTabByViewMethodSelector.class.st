Class {
	#name : #GtInspectorTabByViewMethodSelector,
	#superclass : #GtInspectorTabSelector,
	#instVars : [
		'methodSelector'
	],
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #actions }
GtInspectorTabByViewMethodSelector >> matchesTab: aTabModel [ 
	| currentViewSelector |
	currentViewSelector := aTabModel widget phlow entity methodSelector.
	^ currentViewSelector = self methodSelector
]

{ #category : #accessing }
GtInspectorTabByViewMethodSelector >> methodSelector [
	^ methodSelector
]

{ #category : #accessing }
GtInspectorTabByViewMethodSelector >> methodSelector: aSelector [
	methodSelector := aSelector
]

{ #category : #printing }
GtInspectorTabByViewMethodSelector >> printOn: aStream [
	aStream 
		nextPutAll: 'Select view with selector: ';
		print: self methodSelector
]
