Class {
	#name : #Gt2InspectorAutoInitializedExtensions,
	#superclass : #Gt2InspectorExtensions,
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #defaults }
Gt2InspectorAutoInitializedExtensions >> defaultCollection [
	^ Array streamContents: [ :aStream | 
		Gt2InspectorExtension allSubclassesDo: [ :eachSubclass |
			eachSubclass isAbstract ifFalse: [ 
				aStream nextPut: eachSubclass newExtension ] ] ]
]
