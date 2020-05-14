Class {
	#name : #GtOldInspectorSystemChangesHandler,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtInspectorPageModelChecker',
	#classTraits : 'TBlDebug classTrait + TGtInspectorPageModelChecker classTrait',
	#instVars : [
		'inspector',
		'classes',
		'isSubscribedToSystem'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #adding }
GtOldInspectorSystemChangesHandler >> addClass: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'Observed class must be non-nil' ].
	classes add: aClass.
	self subscribeToSystem
]

{ #category : #accessing }
GtOldInspectorSystemChangesHandler >> classes [
	^ classes
]

{ #category : #'announcement handling' }
GtOldInspectorSystemChangesHandler >> handleClassAnnouncement: aClassAnnouncement [ 
	(self classes anySatisfy: [ :eachClass |
		self doesClass: eachClass isOrInheritsFrom: aClassAnnouncement classAffected ]) 
			ifFalse: [ ^ self ].
	self updatePagesWithClass: aClassAnnouncement classAffected.
]

{ #category : #'announcement handling' }
GtOldInspectorSystemChangesHandler >> handleMethodAnnouncement: aMethodModified [ 
	(self classes anySatisfy: [ :eachClass | 
		self doesClass: eachClass isOrInheritsFrom: aMethodModified classAffected ]) 
			ifFalse: [ ^ self ].
	(self isPhlowView: aMethodModified methodAffected) ifTrue: [ 
		^ self 
			updatePageViewForClass: aMethodModified classAffected
			andMethod: aMethodModified methodAffected ].
	self updatePagesWithClass: aMethodModified classAffected.
]

{ #category : #'announcement handling' }
GtOldInspectorSystemChangesHandler >> handleMethodRemovedAnnouncement: aMethodRemoved [ 
	(self classes anySatisfy: [ :eachClass | 
		self doesClass: eachClass isOrInheritsFrom: aMethodRemoved classAffected ]) 
			ifFalse: [ ^ self ].
	(self isPhlowView: aMethodRemoved methodAffected) ifTrue: [ 
		^ self 
			removePageViewForClass: aMethodRemoved classAffected
			andMethod: aMethodRemoved methodAffected ].
	self updatePagesWithClass: aMethodRemoved classAffected.
]

{ #category : #initialization }
GtOldInspectorSystemChangesHandler >> initialize [
	super initialize.
	classes := OrderedCollection new.
	isSubscribedToSystem := false.
	
]

{ #category : #accessing }
GtOldInspectorSystemChangesHandler >> inspector: anObject [
	inspector := anObject
]

{ #category : #testing }
GtOldInspectorSystemChangesHandler >> isPhlowView: aCompiledMethod [ 
	<return: #Boolean>
	^ aCompiledMethod pragmas anySatisfy: [ :eachPragma | 
		GtPhlowViewsCollector defaultViewPragmaNames includes: eachPragma selector ]
]

{ #category : #testing }
GtOldInspectorSystemChangesHandler >> isSubscribedToSystem [
	^ isSubscribedToSystem
]

{ #category : #updating }
GtOldInspectorSystemChangesHandler >> removePageViewForClass: aClass andMethod: aCompiledMethod [ 
	self scheduleTask: (GtInspectorRemovePageViewWithMethod new
		inspectorInstance: inspector;
		affectedClass: aClass;
		compiledMethod: aCompiledMethod)
]

{ #category : #schedulling }
GtOldInspectorSystemChangesHandler >> scheduleTask: aTask [
	| aCommand |
	aCommand := BlTaskAtPostponedTerminableTask new
		command: aTask;
		beShiftingNotScheduledHandler;
		scheduledTime: BlTime real now + 200 milliSeconds.
	BlTaskAtQueue default schedule: aCommand
]

{ #category : #subscriptions }
GtOldInspectorSystemChangesHandler >> subscribeToSystem [
	self isSubscribedToSystem
		ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement
		send: #handleClassAnnouncement:
		to: self.
	SystemAnnouncer uniqueInstance weak
		when: MethodAnnouncement - MethodRemoved
		send: #handleMethodAnnouncement:
		to: self.
	SystemAnnouncer uniqueInstance weak
		when: MethodRemoved
		send: #handleMethodRemovedAnnouncement:
		to: self.
	isSubscribedToSystem := true
]

{ #category : #subscriptions }
GtOldInspectorSystemChangesHandler >> unsubscribeFromSystem [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isSubscribedToSystem := false.
]

{ #category : #updating }
GtOldInspectorSystemChangesHandler >> updatePageViewForClass: aClass andMethod: aCompiledMethod [ 
	self scheduleTask: (GtInspectorUpdatePageViewWithMethod new
		inspectorInstance: inspector;
		affectedClass: aClass;
		compiledMethod: aCompiledMethod)
]

{ #category : #updating }
GtOldInspectorSystemChangesHandler >> updatePagesWithClass: aClass [ 
	self scheduleTask: (GtInspectorUpdatePagesWithClassTask new
		inspectorInstance: inspector;
		affectedClass: aClass)
]
