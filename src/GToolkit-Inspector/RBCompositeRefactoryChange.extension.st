Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtChangesFor: aView [
	<gtView>
	^ aView explicit
		title: 'Changes';
		stencil: [ | pane changesElement applyButton progress |
			pane := BrVerticalPane new.
			pane matchParent.
			changesElement := GtChangesElement new.
			changesElement changes: self.
			pane addChild: changesElement.
			progress := BrProgress new.
			progress aptitude: BrGlamorousProgressBarAptitude.
			progress
				margin: (BlInsets
						top: 5
						left: 10
						bottom: 15
						right: 10).
			progress
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
			progress visibility: BlVisibility hidden.
			applyButton := BrButton new
					icon: BrGlamorousVectorIcons accept;
					beSmallSize;
					aptitude: BrGlamorousButtonWithIconAptitude new;
					label: 'Save';
					margin: (BlInsets
							top: 0
							left: 10
							bottom: 10
							right: 0);
					action: [ applyButton disable.
						self changesSize > 1 ifTrue: [ progress visibility: BlVisibility visible ].
						progress fraction: 0.
						(changesElement
							applyChangesWithProgress: [ :fraction | progress enqueueTask: (BlTaskAction new action: [ progress fraction: fraction ]) ])
							then: [ :undo | 
								pane
									enqueueTask: (BlTaskAction new
											action: [ progress visibility: BlVisibility hidden.
												applyButton enable ]) ] ];
					yourself.
			pane
				addChild: (BrHorizontalPane new
						vFitContent;
						hMatchParent;
						addChild: applyButton;
						addChild: progress).
			pane ]
]

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtChildren [
	^ self changes
]

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtLabel [
	^ self changes
		ifNotNil: [ self name, ':', self changes size asString, ' changes' ] 
		ifNil: [ '0 changes' ]
]
