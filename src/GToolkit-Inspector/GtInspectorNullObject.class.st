Class {
	#name : #GtInspectorNullObject,
	#superclass : #GtInspectorAbstractObject,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'GToolkit-Inspector-Model'
}

{ #category : #converting }
GtInspectorNullObject >> asElementDo: aOneArgBlock [
	aOneArgBlock cull: self newEmptyElement.
]

{ #category : #'instance creation' }
GtInspectorNullObject >> newEmptyElement [
	^ BrLabel new
		matchParent;
		alignCenter;
		aptitude: BrLabelAptitude;
		text: self newText.
]

{ #category : #'instance creation' }
GtInspectorNullObject >> newText [
	^ 'Nothing inspected' asRopedText foreground: BrGlamorousColors disabledButtonTextColor
]

{ #category : #notifying }
GtInspectorNullObject >> notifyObjectChangedIn: anInspector [
	anInspector notifyObjectRemoved.
]

{ #category : #accessing }
GtInspectorNullObject >> object [
	"Return an inspecting object"
	^ nil
]

{ #category : #printing }
GtInspectorNullObject >> printOn: aStream [ 
	aStream nextPutAll: 'Null Object Holder'
]
