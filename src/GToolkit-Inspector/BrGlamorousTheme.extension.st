Extension { #name : #BrGlamorousTheme }

{ #category : #'*GToolkit-Inspector' }
BrGlamorousTheme >> gtThemeEditorFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Theme';
		priority: 5;
		stencil: [ GtBlocThemeEditorElement new editTheme: self ];
		actionUpdateButton
]
