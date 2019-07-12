Class {
	#name : #GtInspectorSystemChangesHandler,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtInspectorPageModelChecker',
	#classTraits : 'TBlDebug classTrait + TGtInspectorPageModelChecker classTrait',
	#instVars : [
		'inspector',
		'classes',
		'tasker',
		'isSubscribedToSystem'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #adding }
GtInspectorSystemChangesHandler >> addClass: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'Observed class must be non-nil' ].
	classes add: aClass.
	self subscribeToSystem
]

{ #category : #accessing }
GtInspectorSystemChangesHandler >> classes [
	^ classes
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesHandler >> handleClassAnnouncement: aClassAnnouncement [ 
	(self classes anySatisfy: [ :eachClass |
		self doesClass: eachClass isOrInheritsFrom: aClassAnnouncement classAffected ]) 
			ifFalse: [ ^ self ].
	self updatePagesWithClass: aClassAnnouncement classAffected.
]

{ #category : #'announcement handling' }
GtInspectorSystemChangesHandler >> handleMethodAnnouncement: aMethodModified [ 
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
GtInspectorSystemChangesHandler >> handleMethodRemovedAnnouncement: aMethodRemoved [ 
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
GtInspectorSystemChangesHandler >> initialize [
	super initialize.
	classes := OrderedCollection new.
	tasker := GtTasker orderedNonRepetitive asPostponingTasker.
	isSubscribedToSystem := false.
	
]

{ #category : #accessing }
GtInspectorSystemChangesHandler >> inspector: anObject [
	inspector := anObject
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

{ #category : #updating }
GtInspectorSystemChangesHandler >> removePageViewForClass: aClass andMethod: aCompiledMethod [ 
	tasker addTask: (GtInspectorRemovePageViewWithMethod new
		inspectorInstance: inspector;
		affectedClass: aClass;
		compiledMethod: aCompiledMethod)
]

{ #category : #subscriptions }
GtInspectorSystemChangesHandler >> subscribeToSystem [
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
GtInspectorSystemChangesHandler >> unsubscribeFromSystem [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isSubscribedToSystem := false.
]

{ #category : #updating }
GtInspectorSystemChangesHandler >> updatePageViewForClass: aClass andMethod: aCompiledMethod [ 
	tasker addTask: (GtInspectorUpdatePageViewWithMethod new
		inspectorInstance: inspector;
		affectedClass: aClass;
		compiledMethod: aCompiledMethod)
]

{ #category : #updating }
GtInspectorSystemChangesHandler >> updatePagesWithClass: aClass [ 
	tasker addTask: (GtInspectorUpdatePagesWithClassTask new
		inspectorInstance: inspector;
		affectedClass: aClass)
]
