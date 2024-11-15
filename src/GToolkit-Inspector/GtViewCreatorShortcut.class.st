Class {
	#name : #GtViewCreatorShortcut,
	#superclass : #GtSourceCoderShortcut,
	#instVars : [
		'viewCreator'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'as yet unclassified' }
GtViewCreatorShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement coder: aGtSourceCoder dueTo: aShortcutEvent requesterObject: aRequester [
	viewCreator showOn: aBrEditorElement
]

{ #category : #accessing }
GtViewCreatorShortcut >> viewCreator [
	^ viewCreator
]

{ #category : #accessing }
GtViewCreatorShortcut >> viewCreator: anObject [
	viewCreator := anObject
]
