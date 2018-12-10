Class {
	#name : #GtInspectorSystemChangesHandler,
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

{ #category : #testing }
GtInspectorSystemChangesHandler >> doesClass: anAffectedClass isOrInheritsFrom: aClass [
	<return: #Boolean>
	^ anAffectedClass = aClass or: [ anAffectedClass inheritsFrom: aClass ]
]

{ #category : #testing }
GtInspectorSystemChangesHandler >> doesPage: aBrPagerPageModel displayClass: aClass [ 
	^ self 
		doesClass: aBrPagerPageModel model class instanceSide
		isOrInheritsFrom: aClass
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
		self flag: #todo
		"^ self 
			updatePageViewForClass: aMethodModified classAffected
			andMethod: aMethodModified methodAffected" ].
	self updatePagesWithClass: aMethodRemoved classAffected.
]

{ #category : #initialization }
GtInspectorSystemChangesHandler >> initialize [
	super initialize.
	classes := OrderedCollection new.
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

{ #category : #subscriptions }
GtInspectorSystemChangesHandler >> subscribeToSystem [
	self isSubscribedToSystem ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		subscribe: ClassAnnouncement 
		send: #handleClassAnnouncement:
		to: self.
	SystemAnnouncer uniqueInstance weak 
		subscribe: MethodAnnouncement - MethodRemoved
		send: #handleMethodAnnouncement:
		to: self.
	SystemAnnouncer uniqueInstance weak 
		subscribe: MethodRemoved
		send: #handleMethodRemovedAnnouncement:
		to: self.
	isSubscribedToSystem := true.
]

{ #category : #subscriptions }
GtInspectorSystemChangesHandler >> unsubscribeFromSystem [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isSubscribedToSystem := false.
]

{ #category : #updating }
GtInspectorSystemChangesHandler >> updatePageViewForClass: aClass andMethod: aCompiledMethod [ 
	inspector pager pages do: [ :eachPage | 
		(self doesPage: eachPage displayClass: aClass) ifTrue: [ 
			GtInspectorPageViewUpdater new
				inspectorWidget: inspector;
				pagerPageModel: eachPage;
				viewMethodDefinition: aCompiledMethod asRingDefinition;
				update ] ]
]

{ #category : #updating }
GtInspectorSystemChangesHandler >> updatePagesWithClass: aClass [ 
	inspector pager pages do: [ :eachPage | 
		(self doesPage: eachPage displayClass: aClass) 
			ifTrue: [ inspector enqueueTask: (
				BlTaskAction new action: [ inspector updatePageModelWidget: eachPage ]) ] ]
]
