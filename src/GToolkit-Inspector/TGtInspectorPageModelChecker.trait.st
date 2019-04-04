Trait {
	#name : #TGtInspectorPageModelChecker,
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #testing }
TGtInspectorPageModelChecker >> doesClass: anAffectedClass isOrInheritsFrom: aClass [
	<return: #Boolean>
	(aClass = Object or: [ aClass = ProtoObject ]) ifTrue: [ ^ false ].
	^ anAffectedClass = aClass or: [ anAffectedClass inheritsFrom: aClass ]
]

{ #category : #testing }
TGtInspectorPageModelChecker >> doesPage: aBrPagerPageModel displayClass: aClass [ 
	^ self 
		doesClass: aBrPagerPageModel model class instanceSide
		isOrInheritsFrom: aClass
]
