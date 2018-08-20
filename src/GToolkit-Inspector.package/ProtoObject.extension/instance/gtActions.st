*GToolkit-Inspector
gtActions
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
		[ thisContext
					object: self
					perform: eachPragma methodSelector
					withArguments: {}
					inClass: self class ]
			"on: Error
			do: [ :error |
				error freeze.
				GtPhlowViewWithError new 
					title: 'Error';
					error: error ]"
	 ].