Extension { #name : #GtPharoMethodsCoderByScripterExamples }

{ #category : #'*GToolkit-Inspector' }
GtPharoMethodsCoderByScripterExamples >> clickClassTagInBlElementIdReferences [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			scripterForBlock: [ GtPagerSettings usedPager
					createWrappedOn: ((BlElementId named: #toggle) gtReferencesFor: GtPhlowView empty)  ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Click a class tag';
				id: GtPharoHeaderProviderBehaviorId;
				onChildAt: 1 ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Check class isn''t UndefinedObject';
				exists;
				// GtBehaviorCoderBehaviorNameId;
				@ [ :each | each text asString ~= 'UndefinedObject' ] ].
	^ scripter
]
