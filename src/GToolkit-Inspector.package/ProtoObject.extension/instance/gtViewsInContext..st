*GToolkit-Inspector
gtViewsInContext: aContext
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