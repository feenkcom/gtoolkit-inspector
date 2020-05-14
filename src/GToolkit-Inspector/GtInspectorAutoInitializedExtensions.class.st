Class {
	#name : #GtInspectorAutoInitializedExtensions,
	#superclass : #GtInspectorExtensions,
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #defaults }
GtInspectorAutoInitializedExtensions >> defaultCollection [
	^ Array streamContents: [ :aStream | 
		GtInspectorExtension allSubclassesDo: [ :eachSubclass |
			eachSubclass isAbstract ifFalse: [ 
				aStream nextPut: eachSubclass newExtension ] ] ]
]
