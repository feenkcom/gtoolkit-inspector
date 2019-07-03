Extension { #name : #BlElement }

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtChangesFor: aView [
	<gtView>
	^ (self changes gtItemsFor: aView) 
		title: 'Changes';
		priority: 30
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtChildrenFor: aView [
	<gtView>
	^ aView tree
		title: 'Children';
		items: [ {self} ];
		children: #children
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtEditorFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Editor';
		priority: 13;
		stencil: [ | theEditors container |
			theEditors := GtDiagrammerFigureEditor editorsOf: self.
			
			container := BlElement new.
			container layout: BlLinearLayout vertical.
			container constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			
			theEditors do: [ :anEditor |
				| aTitle |
				aTitle := BlTextElement new text: (anEditor title asRopedText).
				aTitle margin: (BlInsets all: 5). 
				container addChild: aTitle.
				container addChild: anEditor editor ].
			
			container ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ 
			self hasParent
				ifTrue: [ 
					| container label |
					container := BlElement new constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ];
						layout: BlLinearLayout vertical;
						padding: (BlInsets all: 10).
					label := BrEditor new 
						look: BrGlamorousRegularEditorLook new;
						text: ('This element cannot be embedded here as it already has a parent. In the meantime, here is its static preview:') asRopedText readonly;
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical fitContent ].
					container addChild: label.
					container addChild: (BlElement new
						look: BrShadowLook;
						layout: BlLinearLayout new;
						background: Color white;
						constraintsDo: [:c | c horizontal fitContent. c vertical fitContent ];
						addChild: self asSpartaForm asElement)
						.
					container ]
				ifFalse: [ 
					| container |
					container := BlElement new
						layout: BlLinearLayout new;
						padding: (BlInsets all: 10);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ]. 
						container addChild: self.
						container when: BlClickEvent do: [:event | self requestFocus].
						container ]  ];
		actionStencil: [ 
			BrToggle new 
				look: BrMaterialToggleBackgroundLook + BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons help asElement;
				when: BrToggleActivatedEvent do: [ BlDevResizer on: self ];
				when: BrToggleDeactivatedEvent do: [ BlDevResizer removeFrom: self ] ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtLookChangesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Look changes';
		priority: 10;
		stencil: [ self look
				ifNil: [ BlElement new ]
				ifNotNil: [ :e | 
					| tree |
					tree := BrColumnedTree new.
					tree
						items: {e}
						children: [ :f | 
							(f isKindOf: BrLook)
								ifTrue: [ f children , f changes changes ]
								ifFalse: [ #() ] ].
					tree column
						title: 'Name';
						width: 350;
						stencil: [ :f | 
							BrColumnCellLabelStencil new
								text:
									((f value isKindOf: BrLook)
										ifTrue: [ f value class name ]
										ifFalse: [ f value printString ]) asRopedText glamorousRegularFont ].
					tree column
						title: 'Toogle';
						width: 32;
						stencil: [ :f | 
							(f value isKindOf: BrLookChange)
								ifTrue: [ BrToggle new
										look: BrHydraSwitchWithoutTrackLook new;
										margin: (BlInsets all: 3);
										activated: f value initialized;
										when: BrToggleActivatedEvent
											do: [ :g | f value upOn: f parent value ];
										when: BrToggleDeactivatedEvent
											do: [ :g | f value downOn: f parent value ];
										yourself ]
								ifFalse: [ BlElement new size: 0 @ 0 ] ].
					tree column
						title: 'Source';
						width: 32;
						stencil: [ :f | 
							(f value isKindOf: BrLookChange)
								ifTrue: [ BrButton new
										look: BrGlamorousButtonWithIconLook;
										margin: (BlInsets all: 3);
										icon: BrGlamorousIcons inspect asElement;
										label: 'Source' translated;
										action: [ :g | 
											g
												fireEvent:
													(GtPhlowObjectToSpawn new
														object: f value source;
														sourceElement: g) ];
										yourself ]
								ifFalse: [ BlElement new size: 0 @ 0 ] ].
					tree ] ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtMeasurementChainFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Measurement' translated;
		priority: 15;
		items: [ 
			| withAllParents |
			withAllParents := (Array streamContents: [ :aStream |
				| currentElement |
				currentElement := self.
				aStream nextPut: currentElement.
				[ currentElement hasParent ] whileTrue: [ 
					currentElement := currentElement parent.
					aStream nextPut: currentElement ] ]) reversed ];
		column: 'Index' item: [ :anElement :anIndex | anIndex ] width: 50;
		column: 'Width spec' 
			item: [ :anElement :anIndex | 
				anElement layout previousMeasurementSpec 
					ifNotNil: #widthSpec ] 
			width: 100;
		column: 'Height spec' 
			item: [ :anElement :anIndex | 
				anElement layout previousMeasurementSpec 
					ifNotNil: #heightSpec ] 
			width: 100;
		column: 'Layout' item: [ :anElement :anIndex | anElement layout ];
		column: 'Element' item: [ :anElement :anIndex | anElement ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtMetricsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Metrics';
		priority: 20;
		stencil: [ BlMetricsInspector new
			padding: (BlInsets all: 10); 
			for: self ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtOpenInSpaceFor: anAction [
	<gtAction>
	self hasParent ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		BrButton new
			look: BrGlamorousButtonWithIconLook; 
			action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
			icon: BrGlamorousIcons play asElement;
			label: 'Open in Space' translated ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Preview';
		priority: 1;
		stencil: [ self asSpartaForm asElement 
			margin: (BlInsets all: 10) ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtResizersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Resizers' translated;
		priority: 10;
		items: [ self withAllParents reversed ];
		column: 'Icon' do: [ :aColumn |
			aColumn itemStencil: [ :each |
				(each asSpartaForm scaledToSize: 16@16) asElement
					margin: (BlInsets all: 3) ];
				width: 19 ];
		column: 'Width' 
			item: [ :anElement | anElement constraints horizontal resizer ];
		column: 'Height' 
			item: [ :anElement | anElement constraints vertical resizer ];
		column: 'Layout' 
			item: [ :anElement | anElement layout ];
		column: 'Element' item: [ :anElement | anElement layout ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtShortcutsFor: aView [
	<gtView>
	self shortcuts ifEmpty: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Shortcuts' translated;
		priority: 10;
		items: [ self shortcuts asArray ];
		column: 'Key' do: [:aColumn | 
			aColumn item: [ :each | each combination gtDisplayString ]; matchParent ];
		column: 'Action' do: [:aColumn |
			aColumn item: [ :each | each action asString ]; matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtUserDataFor: aView [
	<gtView>
	^ (self userData gtItemsFor: aView) 
		title: 'User data';
		priority: 5
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtWidgetGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Widget';
		priority: 10;
		painting: [ :view | self gtInspectorPaintModelLookIn: view ]
]
