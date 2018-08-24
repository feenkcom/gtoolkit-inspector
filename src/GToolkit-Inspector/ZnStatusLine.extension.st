Extension { #name : #ZnStatusLine }

{ #category : #'*GToolkit-Inspector' }
ZnStatusLine >> gtHttpFor: aView [
	<gtView>
	^ aView explicit
		title: 'HTTP';
		priority: 30;
		stencil: [ | anEditor |
			anEditor := BrTextEditor new.
			anEditor text: (String streamContents: [ :out | self writeOn: out ]) asRopedText.
			BrEditorElement new
				editor: anEditor;
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ] ]
]
