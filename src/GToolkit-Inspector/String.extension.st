Extension { #name : #String }

{ #category : #'*GToolkit-Inspector' }
String >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 15;
		stencil: [
		| container list editor |
		container := BlElement new
			constraintsDo: [:c | 
				c vertical matchParent. 
				c horizontal matchParent];
			margin: (BlInsets top: 10 bottom: 10);
			layout: (BlLinearLayout horizontal cellSpacing: 10).
		editor := BrEditorElement new
				constraintsDo: [ :c | 
					c vertical matchParent. 
					c horizontal matchParent.
					c linear weight: 4 ];
				editor: (BrTextEditor new
				text: (self asRopedText glamorousRegularFont);
				when: BrTextEditorCursorMovedEvent do: [:e | 
					list selectOne: (e newIndex max: 1).
					list children first scrollToPosition: (e newIndex max: 1) ];
				when: BrTextEditorCursorAddedEvent do: [:e | 
					list selectOne: (e cursor position max: 1).
					list children first scrollToPosition: (e cursor position max: 1) ]).
		container addChild: editor.
		
		list := BrColumnedList new
			constraintsDo: [:c | 
				c vertical matchParent. 
				c horizontal matchParent ];
			items: (self asOrderedCollection collectWithIndex: [ :char :index | char -> index ]);
			when: BrSelectionChanged do: [ :event | 
				event selectedInterval ifNotNil: [ 
					editor editor text clearAttributes: [ :each | each isKindOf: GtPlaygroundEvaluatedCodeButtonAttribute ].
					(editor editor text from: event selectedInterval first to: event selectedInterval last) attribute: (GtPlaygroundEvaluatedCodeButtonAttribute new paint: (BrGlamorousColors primaryBorderColor); beAppend).
					"(editor scrollToPosition: event selectedInterval first)."
					editor editor updateAll; invalidateAll ] ].
		list column 
			title: 'Index';
			stencil: [ :assoc | BrListLabelStencil new text: (assoc value asString asRopedText glamorousRegularFont; foreground: Color gray; fontSize: 11)].
		list column 
			title: 'Char';
			stencil: [ :assoc | BrListLabelStencil new text: ((assoc key printString gtRemovePrefix: 'Character ') asRopedText glamorousRegularFont; fontSize: 11)].
		container addChild: list.
		
		container 
		]
]

{ #category : #'*GToolkit-Inspector' }
String >> gtStringFor: aView [
	<gtView>
	^ aView textEditor
		title: 'String';
		priority: 9;
		text: [ 
			self asRopedText 
				weight: 400;
				fontName: 'Source Sans Pro';
				fontSize: 14 ]
]
