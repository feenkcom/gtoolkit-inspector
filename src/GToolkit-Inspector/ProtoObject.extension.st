Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionBrowseFor: anAction [
	<gtAction>
	^ anAction explicit stencil: [
		BrButton new
			look: BrGlamorousButtonWithIconLook;
			icon: BrGlamorousIcons browse asElement;
			action: [ Smalltalk tools browser openOnClass: self class ] ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionInspectFor: anAction [
	<gtAction>
	| button |
	^ anAction explicit stencil: [
		button := BrButton new.
		button
			look: BrGlamorousButtonWithIconLook;
			icon: BrGlamorousIcons inspect asElement;
			action: [ 
				button fireEvent: (GtPhlowObjectToSpawn new
					object: self;
					sourceElement: button) ] ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionSearchFor: anAction [
	<gtAction>
	^ anAction explicit stencil: [
	| dropdown |
	dropdown := BrDropdown new.
	dropdown
		look:
			(BrGlamorousDropdownLook new
				outskirtsEmbellisher: [ :e | 
					e
						background: BrGlamorousColors lightBorderColor;
						yourself ];
				yourself);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		toggle: [ BrButton new
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons search asElement;
				when: BlElementBackgroundChangedEvent
					do: [ :e | 
					(dropdown isExpanded
						and: [ e target background paint color
								~= BrGlamorousColors lightBorderColor ])
						ifTrue: [ e target background: BrGlamorousColors lightBorderColor ] ];
				yourself ];
		popup: [ | model |
			model := GtSpotter new initializeWith: self.
			model announcer
				when: GtSpotterActOn
				do: [ :e | 
					| item |
					item := e element.
					e actedUpon: true.
					self flag: 'FIXME candidates may be wrapped for some reason'.
					[ (item isKindOf: GtSpotterCandidate) and: [ item item ~~ item ] ]
						whileTrue: [ item := item item ].
					dropdown phlow spawnObject: item ].
			GtSpotterElement new
				spotterModel: model;
				constraintsDo: [ :c | 
					c horizontal exact: 600.
					c vertical exact: 400 ];
				margin: (BlInsets all: 1);
				geometry: (BlRectangle cornerRadius: 4);
				in: [ :e | 
					self
						flag: 'FIXME need to remove original listener to avoid phlow inspect'.
					model announcer subscriptions subscriptions
						detect: [ :g | 
							g announcementClass == GtSpotterSelectedCandidateChanged
								and: [ g action isMessageSend
										and: [ g action selector = #onCandidateSelected:
												and: [ g action receiver == e ] ] ] ]
						ifFound: [ :g | g announcer subscriptions remove: g ] ];
				yourself ];
		yourself ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActions [
	"This collects all view actions for the current object.
	By default, it simply looks for the #gtAction pragma.
	Subclasses might want to override it for more special behavior."
	<return: #Array of: #GtPhlowAction>
	^ GtPhlowActionsCollector new
		pragmaName: #gtAction;
		fromObject: self;
		collect
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtIcon [
	^ BrGlamorousIcons empty
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtInspect [ 
	^ GtInspector openOn: self
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject class >> gtSubclassesFor: aView [
	<gtView>
	self subclasses ifNil: [ ^ aView empty ].
	^ aView tree
		title: 'Subclasses';
		items: [ { self } ];
		children: #subclasses
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsFor: aView [
	"this is the default entry method for retrieving the wrapper view containing all views"
	^ self gtViewsFor: aView inContext: nil
		
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsFor: aView inContext: aContext [
	| className title displayText resultingView header |
	className := self class name.
	header := (className first isVowel ifTrue: [ 'an ' ] ifFalse: [ 'a ' ]), className.
	displayText := [ (String streamContents: [ :stream | self gtDisplayOn: stream ]) asRopedText ]
			on: Error 
			do: [ :e | 'Error printing' asRopedText foreground: Color red ].
	title := (displayText asString beginsWith: header) 
		ifTrue: [ displayText ]
		ifFalse: [ 
			String streamContents: [ :stream |
				stream
					nextPutAll: (className first isVowel ifTrue: ['an '] ifFalse: ['a ']);
					nextPutAll: className;
					nextPutAll: ' (';
					nextPutAll: displayText;
					nextPutAll: ')' ] ].
	resultingView := ((aView composite
		views: (self gtViewsInContext: aContext))
		labelled: title).
	self gtActions do: [ :action | 
		action isDefaultTarget ifTrue: [ 
			resultingView addPhlowAction: action ] ].
	^ resultingView
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsInContext: aContext [
	"This collects all views for the current object.
	By default, it simply looks for the #gtView pragma.
	The inspector can decice whether or not a presentation should be displayed.
	Subclasses might want to override it for more special behavior.
	aContext holds the context of the inspection session (i.e, the previous steps)"
	^ GtPhlowViewsCollector new
		fromObject: self;
		context: aContext;
		collect.
]
