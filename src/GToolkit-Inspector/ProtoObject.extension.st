Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActionBrowseFor: anAction [
	<gtAction>
	| button |
	^ anAction explicit stencil: [
		button := BrButton new.
		button
			look: BrGlamorousButtonExteriorRectangularLook + 
					BrGlamorousButtonIconLook;
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
			look: BrGlamorousButtonExteriorRectangularLook + 
					BrGlamorousButtonIconLook;
			icon: BrGlamorousIcons inspect asElement;
			action: [ 
				button fireEvent: (GtPhlowObjectToSpawn new
					object: self;
					sourceElement: button) ] ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtActions [
	"This collects all views for the current object.
	By default, it simply looks for the #gtView: pragma.
	The inspector can decice whether or not a presentation should be displayed.
	Subclasses might want to override it for more special behavior.
	aContext holds the context of the inspection session (i.e, the previous steps)"
	| pragmas |
	pragmas := Pragma
		allNamed: #gtAction
		from: self class
		to: ProtoObject
		sortedUsing: [ :x :y | (x key) < (y key) ].
	"pragmas select: [ :aPragma | aGTInspector shouldDisplayPresentationCreatedBy: aPragma method ]"
	^ pragmas collect: [ :eachPragma | 
		| action |
		action := GtPhlowNoAction new.
		 [thisContext
					object: self
					perform: eachPragma methodSelector
					withArguments: {action}
					inClass: self class ]
			on: Error
			do: [ :error |
				error freeze.
				GtPhlowActionWithError new 
					error: error ]
	 ].
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
	self gtActions do: [ :action | resultingView addPhlowAction: action. ].
	^ resultingView
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsFromPragmas: aCollection inContext: aContext [
	| views |
	views := aCollection collect: [ :eachPragma | 
		| view |
		view := GtPhlowEmptyView new.
		eachPragma methodSelector numArgs = 1
			ifTrue: [ 
				view := [ thisContext
							object: self
							perform: eachPragma methodSelector
							withArguments: {view}
							inClass: self class]
					on: Error
					do: [ :error |
						error freeze.
						GtPhlowViewWithError new 
							title: 'Error';
							error: error ] ].
		eachPragma methodSelector numArgs = 2
			ifTrue: [ 
				view := thisContext
					object: self
					perform: eachPragma methodSelector
					withArguments:
						{view.
						aContext}
					inClass: self class ].
		view ].
	^ views sorted: [ :a :b | 
		[a priority < b priority]
			on: Error
			do: [ :error | true ] ]
]

{ #category : #'*GToolkit-Inspector' }
ProtoObject >> gtViewsInContext: aContext [
	"This collects all views for the current object.
	By default, it simply looks for the #gtView: pragma.
	The inspector can decice whether or not a presentation should be displayed.
	Subclasses might want to override it for more special behavior.
	aContext holds the context of the inspection session (i.e, the previous steps)"
	| pragmas |
	pragmas := (Pragma
			allNamed: #gtView
			from: self class
			to: ProtoObject) , 
		(Pragma
			allNamed: #gtView:
			from: self class
			to: ProtoObject).
	"pragmas select: [ :aPragma | aGTInspector shouldDisplayPresentationCreatedBy: aPragma method ]"
	^ self gtViewsFromPragmas: pragmas inContext: aContext
]
