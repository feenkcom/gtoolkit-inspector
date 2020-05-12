Class {
	#name : #Gt2InspectorNullObjectHolder,
	#superclass : #Gt2InspectorProtoObjectHolder,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Inspector-! New - Model'
}

{ #category : #converting }
Gt2InspectorNullObjectHolder >> asElementDo: aOneArgBlock [
	"do nothing"
	aOneArgBlock cull: self newEmptyElement.
]

{ #category : #'instance creation' }
Gt2InspectorNullObjectHolder >> newEmptyElement [
	^ BrLabel new
		matchParent;
		alignCenter;
		look: BrLabelLook;
		text: self newText.
]

{ #category : #'instance creation' }
Gt2InspectorNullObjectHolder >> newText [
	^ 'Nothing inspected' asRopedText foreground: BrGlamorousColors disabledButtonTextColor
]

{ #category : #notifying }
Gt2InspectorNullObjectHolder >> notifyObjectChangedIn: aModel [
	aModel notifyObjectRemoved.
]

{ #category : #accessing }
Gt2InspectorNullObjectHolder >> object [
	"Return an inspecting object"
	^ nil
]

{ #category : #printing }
Gt2InspectorNullObjectHolder >> printOn: aStream [ 
	aStream nextPutAll: 'Null Object Holder'
]
