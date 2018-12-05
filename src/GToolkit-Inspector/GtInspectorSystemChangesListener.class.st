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
GtInspectorSystemChangesListener >> doesPage: aBrPagerPageModel displayClass: aClass [ 
	^ (aBrPagerPageModel model isKindOf: aClass)
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesListener >> handleClassAnnouncement: aClassAnnouncement [ 
	(self classes anySatisfy: [ :eachClass | eachClass = aClassAnnouncement classAffected ]) ifFalse: [ ^ self ].
	self updatePagesWithClass: aClassAnnouncement classAffected.
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesListener >> handleMethodAnnouncement: aMethodModified [ 
	(self classes anySatisfy: [ :eachClass | eachClass = aMethodModified classAffected ]) ifFalse: [ ^ self ].
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
			ifTrue: [ inspector updatePageModelWidget: eachPage ] ]
]
