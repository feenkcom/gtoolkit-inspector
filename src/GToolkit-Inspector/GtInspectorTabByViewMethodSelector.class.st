Class {
	#name : #GtInspectorTabByViewMethodSelector,
	#superclass : #GtInspectorTabSelector,
	#instVars : [
		'methodSelector'
	],
	#category : #'GToolkit-Inspector-Tab Selector'
}

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

{ #category : #actions }
GtInspectorTabByViewMethodSelector >> selectTabIn: aTabGroup on: anObject [
	aTabGroup viewModel tabs
		detect:
			[ :tabModel | 
				| aViewSelector |
				aViewSelector := tabModel widget phlow entity methodSelector.
				aViewSelector = self methodSelector ]
		ifFound: [ :tabModel | tabModel select ]
		ifNone: [ "do nothing" ]
]
