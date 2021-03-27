Extension { #name : #BlElement }

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtChildrenFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Children';
		priority: 35;
		expandUpTo: 2;
		items: [ {self} ];
		children: #children;
		column: 'Preview'
			do: [ :aColumn | aColumn
				stencil: [ :eachElement | 
					self gtPreviewThumbnailFor: eachElement ] ];
		column: 'Type' text: [ :eachElement | eachElement class ];
		column: 'Element' item: [ :anElement | (anElement containerName ifNil: [''] ifNotNil: [ :aContainerName | '#',aContainerName, ' ' ]), anElement asString ];
		column: 'Composition layer'
			item: [ :eachElement | 
				eachElement wantsSeparateCompositingLayer
					ifTrue: [ 'Yes' ]
					ifFalse: [ '' ] ]
			width: 100
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ 
			(self hasParent or: [self isRoot ])
				ifTrue: [ 
					| container label |
					container := BlElement new constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ];
						layout: BlLinearLayout vertical;
						padding: (BlInsets all: 10);
						margin: (BlInsets all: 10).
					container addChild: (BlElement new
						aptitude: BrShadowAptitude;
						layout: BlLinearLayout new;
						background: Color white;
						constraintsDo: [:c | 
							c horizontal matchParent. 
							c vertical matchParent ];
						addChild: self asSpartaForm asElement asPannableElement).
					label := BrLabel new 
						aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
						text: (('You see a static preview because this element already has a parent.') asRopedText glamorousRegularFont readonly);
						alignCenter;
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical fitContent.
							c linear horizontal alignCenter].
					container addChild: label.
					container ]
				ifFalse: [ 
					| container |
					container := BlElement new
						margin: (BlInsets all: 20);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical matchParent ]. 
						container addChild: self.
						container when: BlClickEvent do: [ :event | container requestFocus ].
						container ]  ].
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtMeasurementChainFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Measurement' translated;
		priority: 11;
		items: [ 
			| withAllParents |
			withAllParents := (Array streamContents: [ :aStream |
				| currentElement |
				currentElement := self.
				aStream nextPut: currentElement.
				[ currentElement hasParent ] whileTrue: [ 
					currentElement := currentElement parent.
					aStream nextPut: currentElement ] ]) reversed ];
		column: 'Width spec' 
			item: [ :anElement :anIndex | 
				anElement privatePreviousMeasurementSpec
					ifNotNil: #widthSpec ];
		column: 'Height spec' 
			item: [ :anElement :anIndex | 
				anElement privatePreviousMeasurementSpec
					ifNotNil: #heightSpec ];
		column: 'Layout' item: [ :anElement :anIndex | anElement layout ];
		column: 'Element' item: [ :anElement :anIndex | anElement ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtOpenInSpaceFor: anAction [
	<gtAction>
	self hasParent ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude; 
			action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
			icon: BrGlamorousVectorIcons play;
			label: 'Open in Space' translated ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtOverviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Overview';
		priority: 1;
		stencil: [ GtInspectorElementOverview new
			margin: (BlInsets all: 5);	
			element: self ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtParentsFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Parents';
		priority: 36;
		expandUpTo: 2;
		items: [ {self} ];
		children: [ :each | 
			each hasParent
				ifTrue: [ {each parent} ]
				ifFalse: [ {} ] ];
		column: 'Preview'
			do: [ :aColumn | 
			aColumn
				weight: 1;
				stencil: [ :eachElement | 
					| form |
					form := eachElement asSpartaForm.
					BrButton new
						margin: (BlInsets all: 10);
						icon:
							(BlElement new
								size: 50 @ 20;
								"margin: (BlInsets top: 2 bottom: 2);"
									addChild: form asElement asScalableElement);
						label: 'Slides';
						aptitude:
							BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
								+
									(BrGlamorousWithDropdownAptitude
										handle: [ BrButton new
												aptitude:
													BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
														- BrGlamorousButtonExteriorAptitude;
												icon:
													(BlElement new
														size: 50 @ 20;
														"margin: (BlInsets top: 2 bottom: 2);"
															addChild: form asElement asScalableElement) ]
										content: [ form asElement ]);
						constraintsDo: [ :c | "padding: (BlInsets all: 10) " c linear horizontal alignRight ] ] ];
		column: 'Type' text: [ :eachElement | eachElement class ];
		column: 'Clip children'
			item: [ :eachElement | eachElement clipChildren asString ]
			width: 100
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
BlElement >> gtPreviewThumbnailFor: anElement [
	^ BlLazyElement new 
		layout: BlFrameLayout new; 
		margin: (BlInsets all: 10);
		size: 50 @ 20;
		elementBuilder: [
			| form |
			form := anElement asSpartaForm.
			BrButton new
				icon: (BlElement new
					size: 50 @ 20;
					addChild: form asElement asScalableElement);
				label: 'Slides';
				aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
					+ (BrGlamorousWithDropdownAptitude
							handle: [ BrButton new
								aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
										- BrGlamorousButtonExteriorAptitude;
								icon: (BlElement new
										size: 50 @ 20;
										addChild: form asElement asScalableElement) ]
							content: [ form asElement ]);
				constraintsDo: [ :c | 
					c linear horizontal alignRight ] ];
		postAction: [ :theLazyElement :theChild |
			theLazyElement constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ] ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtResizersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Resizers' translated;
		priority: 10;
		items: [ self withAllParents reversed ];
		column: 'Width'
			item: [ :anElement | anElement constraints horizontal resizer ];
		column: 'Height'
			item: [ :anElement | anElement constraints vertical resizer ];
		column: 'Layout' item: [ :anElement | anElement layout ];
		column: 'Element' item: [ :anElement | anElement ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtShortcutsFor: aView [
	<gtView>
	self shortcuts ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Shortcuts' translated;
		priority: 11;
		items: [ self shortcuts asArray ];
		column: 'Name' item: [ :each | each name ifNil: [ each gtDisplayString ] ];
		column: 'Combination' item: [ :each | each combination gtDisplayString ]
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
		painting: [ :view | self gtInspectorPaintModelAptitudeIn: view ]
]
