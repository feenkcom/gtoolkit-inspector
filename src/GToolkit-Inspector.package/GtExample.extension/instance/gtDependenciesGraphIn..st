*GToolkit-Inspector
gtDependenciesGraphIn: aView
	<gtView: 1>
	"self flag: 'Temporary solution in case rossal is not present'.
	(composite class canPerform: #roassal2) ifFalse: [ ^ self ]."
	^ aView mondrian
		title: 'Graph';
		painting: [ :view | 
			view nodes shape: [ :each |
				| element |
				element := BlElement new.
							element 	
							geometry: BlEllipse new;
							border: (BlBorder paint: Color black width: 2);
							size: 20@20;
							constraintsDo: [ :constraints |
								constraints padding: (BlInsets all: 10).
					each = self ifTrue: [element background: Color gray] ifFalse: [element background:  Color white]  ]. element
				 ];
				"borderColor: Color black;	
				color: [ :each | each = self ifTrue: [Color gray] ifFalse: [Color white]];
				size: 10.	"		
			with: (self withDeepCollect: #directDependencies) asSet.
			view edges connectToAll: #directDependencies.
			view layout tree ]