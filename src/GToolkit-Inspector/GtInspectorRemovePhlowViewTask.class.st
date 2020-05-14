Class {
	#name : #GtInspectorRemovePhlowViewTask,
	#superclass : #GtInspectorUpdatePhlowViewTask,
	#category : #'GToolkit-Inspector-! New - System Observer'
}

{ #category : #execution }
GtInspectorRemovePhlowViewTask >> execute [
	self newUpdater remove
]
