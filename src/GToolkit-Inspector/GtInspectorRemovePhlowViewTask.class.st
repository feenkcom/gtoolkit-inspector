Class {
	#name : #GtInspectorRemovePhlowViewTask,
	#superclass : #GtInspectorUpdatePhlowViewTask,
	#category : #'GToolkit-Inspector-System Observer'
}

{ #category : #execution }
GtInspectorRemovePhlowViewTask >> execute [
	self newUpdater remove
]
