Extension { #name : 'Text' }

{ #category : '*GToolkit-Inspector' }
Text >> gtItemsFor: aView [
	"No items presentation for a Text"

	^ aView empty
]

{ #category : '*GToolkit-Inspector' }
Text >> gtStringFor: aView [
	<gtView>
	^ aView explicit
		title: 'Text';
		priority: 9;
		stencil: [
			BrEditorElement new
				margin: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c vertical matchParent. 
					c horizontal matchParent ];
				editor: (BrTextEditor new
					text: ( self asRopedText
						glamorousRegularFontAndSize) ) ]
]
