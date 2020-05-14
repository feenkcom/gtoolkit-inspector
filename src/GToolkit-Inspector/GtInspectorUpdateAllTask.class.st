Class {
	#name : #GtInspectorUpdateAllTask,
	#superclass : #GtInspectorTask,
	#category : #'GToolkit-Inspector-! New - System Observer'
}

{ #category : #execution }
GtInspectorUpdateAllTask >> execute [
	self inspectorInstance enqueueTask: (
		BlTaskAction new action: [ self inspectorInstance mayUpdateView ])
]

{ #category : #printing }
GtInspectorUpdateAllTask >> printOn: aStream [
	aStream 
		nextPutAll: 'Inspetor total update for ';
		print: self affectedClass
]
