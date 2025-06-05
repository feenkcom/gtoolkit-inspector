Extension { #name : #BlThemeableColor }

{ #category : #'*GToolkit-Inspector' }
BlThemeableColor >> gtColorComputationFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 5;
		object: [ colorComputation ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Inspector' }
BlThemeableColor >> gtThemeableColorComputationFor: aView [
	<gtView>
	^ aView explicit
		title: 'Accessors';
		priority: 3;
		stencil: [ | container description |
			container := BrVerticalPane new matchParent.
			container padding: (BlInsets top: 10).
			description := {
				false -> 'When in a context of a BlElement or BrAptitude:'.
				true -> 'If there is no access to a UI element:'
			} asDictionary.
			 
			#(false true)
				do: [ :useGlobalTheme | 
					| source coder coderViewModel |
					
					container addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						margin: (BlInsets left: 20);
						text: (description at: useGlobalTheme)).
					
					source := GtBlocThemeableProperty
							computePropertyAccessApiFromSourceBlock: themeableColorComputation
							useGlobalTheme: useGlobalTheme.
					coder := GtPharoSnippetCoder forSource: source.
					coderViewModel := coder asCoderViewModel.
					coderViewModel selfObject: self.

					container addChild: coderViewModel asExpandedOnlyElement ].

			container ]
]

{ #category : #'*GToolkit-Inspector' }
BlThemeableColor >> gtThemeableColorReferencesFor: aView [
	<gtView>
	^ aView forward
		title: 'References';
		priority: 4;
		object: [
			| nameSenders localThemeMatches globalThemeMatches |
			
			nameSenders := (GtBlocThemeableColorProperty computePropertyNameSourceBlock: themeableColorComputation) gtSenders.

			localThemeMatches := (GtBlocThemeableProperty
				computePropertyAccessApiFromSourceBlock: themeableColorComputation
				useGlobalTheme: false) gtRBPatternMatches.
			
			globalThemeMatches := (GtBlocThemeableProperty
				computePropertyAccessApiFromSourceBlock: themeableColorComputation
				useGlobalTheme: true) gtRBPatternMatches.
			
			nameSenders & (localThemeMatches | globalThemeMatches) ];
		view: #gtItemsFor:
]
