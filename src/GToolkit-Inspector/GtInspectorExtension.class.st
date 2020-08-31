Class {
	#name : #GtInspectorExtension,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #testing }
GtInspectorExtension class >> isAbstract [
	^ self name = #GtInspectorExtension 
]

{ #category : #testing }
GtInspectorExtension class >> isDeprecated [
	^ true
]

{ #category : #'instance creation' }
GtInspectorExtension class >> newExtension [
	"Subclasses can define how to instantiate a new extension"
	^ self new
]

{ #category : #notifications }
GtInspectorExtension >> addedToSceneGraph [
	"Notification that the inspector was added to a scene graph"
	self subclassResponsibility
]

{ #category : #'widget configuration' }
GtInspectorExtension >> fillToolWidgetIn: aCreationContext [
	"polymorhipc to ${method:GtPagerPageEmbellisherExtension>>#fillToolWidgetIn:}$."
]

{ #category : #accessing }
GtInspectorExtension >> inspectorInstance: anInspector [
	"Set the attached inspector instance"
	self subclassResponsibility
]

{ #category : #notifications }
GtInspectorExtension >> objectChangedTo: anObject [
	self subclassResponsibility
]

{ #category : #notifications }
GtInspectorExtension >> objectRemoved [
	self subclassResponsibility
]

{ #category : #notifications }
GtInspectorExtension >> removedFromSceneGraph [
	"Notification that the inspector was removed from a scene graph"
	self subclassResponsibility
]
