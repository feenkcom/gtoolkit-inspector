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
ProtoObject >> gtViewsFor: aView [
	"this is the default entry method for retrieving the wrapper view containing all views"
	^ self gtViewsFor: aView inContext: nil
		
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsFor: aView inContext: aContext [
	| className title displayText resultingView |
	className := self class name.
	displayText := [ (String streamContents: [ :stream | self gtDisplayOn: stream ]) asRopedText ]
			on: Error 
			do: [ :e | 'Error printing' asRopedText foreground: Color red ].
	title := String streamContents: [ :stream |
		stream
			nextPutAll: (className first isVowel ifTrue: ['an '] ifFalse: ['a ']);
			nextPutAll: className;
			nextPutAll: ' (';
			nextPutAll: displayText;
			nextPutAll: ')' ].
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
