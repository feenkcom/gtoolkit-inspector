Class {
	#name : #GtInspectorSystemChangesHandler,
	#superclass : #GtInspectorExtension,
	#instVars : [
		'isSubscribedToSystem',
		'observedClass',
		'hasObservedClass',
		'inspector'
	],
	#category : #'GToolkit-Inspector-Model'
}

{ #category : #notifications }
GtInspectorSystemChangesHandler >> addedToSceneGraph [
	self subscribeToSystem.
]

{ #category : #testing }
GtInspectorSystemChangesHandler >> doesClass: anAffectedClass isOrInheritsFrom: aClass [
	<return: #Boolean>
	(aClass = Object or: [ aClass = ProtoObject ]) ifTrue: [ ^ false ].
	^ anAffectedClass = aClass or: [ anAffectedClass inheritsFrom: aClass ]
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesHandler >> handleClassAnnouncement: aClassAnnouncement [
	self hasObservedClass ifFalse: [ ^ self ].
	(self doesClass: self observedClass isOrInheritsFrom: aClassAnnouncement classAffected)
		ifFalse: [ ^ self ].
	self updateAllForClass: aClassAnnouncement classAffected.
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesHandler >> handleMethodAnnouncement: aMethodModified [ 
	self hasObservedClass ifFalse: [ ^ self ].
	(self doesClass: self observedClass isOrInheritsFrom: aMethodModified classAffected)
		ifFalse: [ ^ self ].
	(self isPhlowView: aMethodModified methodAffected) ifTrue: [ 
		^ self 
			updatePageViewForClass: aMethodModified classAffected
			andMethod: aMethodModified methodAffected ].
	self updateAllForClass: aMethodModified classAffected.
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesHandler >> handleMethodRemovedAnnouncement: aMethodRemoved [ 
	self hasObservedClass ifFalse: [ ^ self ].
	(self doesClass: self observedClass isOrInheritsFrom: aMethodRemoved classAffected)
		ifFalse: [ ^ self ].
	(self isPhlowView: aMethodRemoved methodAffected) ifTrue: [ 
		^ self 
			removePageViewForClass: aMethodRemoved classAffected
			andMethod: aMethodRemoved methodAffected ].
	self updateAllForClass: aMethodRemoved classAffected.
]

{ #category : #testing }
GtInspectorSystemChangesHandler >> hasObservedClass [
	<return: #Boolean>
	^ hasObservedClass
]

{ #category : #initialization }
GtInspectorSystemChangesHandler >> initialize [
	super initialize.
	hasObservedClass := false.
	isSubscribedToSystem := false.
	
]

{ #category : #accessing }
GtInspectorSystemChangesHandler >> inspectorInstance [
	<return: #GtInspector>
	^ inspector
]

{ #category : #accessing }
GtInspectorSystemChangesHandler >> inspectorInstance: anInspector [
	"Set the attached inspector instance"
	inspector := anInspector
]

{ #category : #testing }
GtInspectorSystemChangesHandler >> isPhlowView: aCompiledMethod [ 
	<return: #Boolean>
	^ aCompiledMethod pragmas anySatisfy: [ :eachPragma | 
		GtPhlowViewsCollector defaultViewPragmaNames includes: eachPragma selector ]
]

{ #category : #testing }
GtInspectorSystemChangesHandler >> isSubscribedToSystem [
	^ isSubscribedToSystem
]

{ #category : #notifications }
GtInspectorSystemChangesHandler >> objectChangedTo: anObject [
	| aClass |
	aClass := anObject class instanceSide.
	self observedClass: aClass.
]

{ #category : #notifications }
GtInspectorSystemChangesHandler >> objectRemoved [
	self removeObservedClass.
]

{ #category : #accessing }
GtInspectorSystemChangesHandler >> observedClass [
	^ observedClass
]

{ #category : #accessing }
GtInspectorSystemChangesHandler >> observedClass: aClass [
	self 
		assert: [ aClass isNotNil ]
		description: [ 'Observed class must be non-nil' ].
	observedClass := aClass.
	hasObservedClass := true.
]

{ #category : #printing }
GtInspectorSystemChangesHandler >> printOn: aStream [
	aStream nextPutAll: 'System changes observer'.
	self hasObservedClass ifTrue: [ 
		aStream 
			nextPutAll: ' for ';
			print: self observedClass ].
	self isSubscribedToSystem 
		ifTrue: [ aStream nextPutAll: ' (subscribed)' ] 
		ifFalse: [ aStream nextPutAll: ' (unsubscribed)' ]
]

{ #category : #accessing }
GtInspectorSystemChangesHandler >> removeObservedClass [
	hasObservedClass := false.
	observedClass := nil.
]

{ #category : #updating }
GtInspectorSystemChangesHandler >> removePageViewForClass: aClass andMethod: aCompiledMethod [ 
	self scheduleTask: (GtInspectorRemovePhlowViewTask new
		inspectorInstance: self inspectorInstance;
		affectedClass: aClass;
		compiledMethod: aCompiledMethod)
]

{ #category : #notifications }
GtInspectorSystemChangesHandler >> removedFromSceneGraph [
	self unsubscribeFromSystem.
]

{ #category : #schedulling }
GtInspectorSystemChangesHandler >> scheduleTask: aTask [
	| aCommand |
	aCommand := BlTaskAtPostponedTerminableTask new
		command: aTask;
		pool: BlTktWorkerProvider highUICPUBoundPool;
		beShiftingNotScheduledHandler;
		scheduledTime: BlTime real now + 200 milliSeconds.
	BlTaskAtQueue default schedule: aCommand
]

{ #category : #subscriptions }
GtInspectorSystemChangesHandler >> subscribeToSystem [
	self isSubscribedToSystem
		ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance
		when: ClassAnnouncement
		send: #handleClassAnnouncement:
		to: self.
	SystemAnnouncer uniqueInstance
		when: MethodAnnouncement - MethodRemoved
		send: #handleMethodAnnouncement:
		to: self.
	SystemAnnouncer uniqueInstance
		when: MethodRemoved
		send: #handleMethodRemovedAnnouncement:
		to: self.
	isSubscribedToSystem := true
]

{ #category : #subscriptions }
GtInspectorSystemChangesHandler >> unsubscribeFromSystem [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isSubscribedToSystem := false.
]

{ #category : #updating }
GtInspectorSystemChangesHandler >> updateAllForClass: anAffecteClass [
	self scheduleTask: (GtInspectorUpdateAllTask new
		inspectorInstance: self inspectorInstance;
		affectedClass: anAffecteClass)
]

{ #category : #updating }
GtInspectorSystemChangesHandler >> updatePageViewForClass: aClass andMethod: aCompiledMethod [ 
	self scheduleTask: (GtInspectorUpdatePhlowViewTask new
		inspectorInstance: self inspectorInstance;
		affectedClass: aClass;
		compiledMethod: aCompiledMethod)
]
