Class {
	#name : #GtInspectorSystemChangesListener,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'inspector',
		'classes',
		'isSubscribedToSystem'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #adding }
GtInspectorSystemChangesListener >> addClass: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'Observed class must be non-nil' ].
	classes add: aClass.
	self subscribeToSystem
]

{ #category : #accessing }
GtInspectorSystemChangesListener >> classes [
	^ classes
]

{ #category : #testing }
GtInspectorSystemChangesListener >> doesClass: anAffectedClass inheritsFrom: aClass [
	<return: #Boolean>
	^ anAffectedClass inheritsFrom: aClass
]

{ #category : #testing }
GtInspectorSystemChangesListener >> doesPage: aBrPagerPageModel displayClass: aClass [ 
	^ self 
		doesClass: aBrPagerPageModel model class instanceSide
		inheritsFrom: aClass
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesListener >> handleClassAnnouncement: aClassAnnouncement [ 
	(self classes anySatisfy: [ :eachClass |
		self doesClass: eachClass inheritsFrom: aClassAnnouncement classAffected ]) 
			ifFalse: [ ^ self ].
	self updatePagesWithClass: aClassAnnouncement classAffected.
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesListener >> handleMethodAnnouncement: aMethodModified [ 
	(self classes anySatisfy: [ :eachClass | 
		self doesClass: eachClass inheritsFrom: aMethodModified classAffected ]) 
			ifFalse: [ ^ self ].
	self updatePagesWithClass: aMethodModified classAffected.
]

{ #category : #initialization }
GtInspectorSystemChangesListener >> initialize [
	super initialize.
	classes := OrderedCollection new.
	isSubscribedToSystem := false.
	
]

{ #category : #accessing }
GtInspectorSystemChangesListener >> inspector: anObject [
	inspector := anObject
]

{ #category : #testing }
GtInspectorSystemChangesListener >> isSubscribedToSystem [
	^ isSubscribedToSystem
]

{ #category : #subscriptions }
GtInspectorSystemChangesListener >> subscribeToSystem [
	self isSubscribedToSystem ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		subscribe: ClassAnnouncement 
		send: #handleClassAnnouncement:
		to: self.
	SystemAnnouncer uniqueInstance weak 
		subscribe: MethodAnnouncement 
		send: #handleMethodAnnouncement:
		to: self.
	isSubscribedToSystem := true.
]

{ #category : #subscriptions }
GtInspectorSystemChangesListener >> unsubscribeFromSystem [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isSubscribedToSystem := false.
]

{ #category : #updating }
GtInspectorSystemChangesListener >> updatePagesWithClass: aClass [ 
	inspector pager pages do: [ :eachPage | 
		(self doesPage: eachPage displayClass: aClass) 
			ifTrue: [ inspector enqueueTask: (
				BlTaskAction new action: [ inspector updatePageModelWidget: eachPage ]) ] ]
]
