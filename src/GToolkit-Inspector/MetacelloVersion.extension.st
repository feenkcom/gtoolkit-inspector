Extension { #name : #MetacelloVersion }

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> = aMetacelloVersion [
	<gtPharoPatch: #Pharo>
	"needed because the super implementation only checks the version number,
	and we also need to ensure that we have the same configuration class"	
	
	aMetacelloVersion species = self species ifFalse: [ ^false ].

	^ (self versionNumber = aMetacelloVersion versionNumber) and: [ 
		self spec project configuration class = aMetacelloVersion spec project configuration class ]
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtDisplayOn: stream [
	stream nextPutAll: self spec project configuration class name
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtPackagesFor: aView [
	<gtView>
	^ aView list
		title: 'Packages';
		priority: 50;
		items: [ self packages ];
		itemText: [ :aNode | 
			[ aNode gtDisplayString asRopedText ]
				on: Error
				do: [ aNode errorMessage asRopedText foreground: Color red ] ]
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtProjectMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Project map';
		priority: 70;
		painting: [ :mondrian |
			mondrian nodes 
				shape: [:each | 
					| text |
					text := [
						((each asString 
							copyReplaceAll: 'baseline [BaselineOf' with: '') 
							copyReplaceAll: 'ConfigurationOf' with: '') asRopedText glamorousRegularFont
						foreground: Color black ]
						on: Error do: [:e | e asString asRopedText glamorousRegularFont foreground: Color red ].
					BlTextElement new text: text ];
				with: ((self 
					withDeepCollect: [ :each | each projects collect: #version ] 
					as: Set) 	reject: #isNil).
			mondrian edges
				shape: [ :each |
					BlLineElement new 
						zIndex: -1;
						border: (BlBorder paint: (Color gray alpha: 0.5) width: 2);
"						curvatureFraction: 0.1;"
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.5); width: 2; build))  ];
				fromRightCenter;
				toLeftCenter;
				connectFrom: #yourself 
				toAll: [:each | each projects collect: #version].
			mondrian layout horizontalDominanceTree nodeDistance: 10; levelDistance: 10 ]
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtProjectsFor: aView [
	<gtView>
	^ aView list
		title: 'Projects';
		priority: 60;
		items: [ self projects ];
		itemText: [ :aNode | 
			[ aNode gtDisplayString asRopedText ]
				on: Error
				do: [ aNode errorMessage asRopedText foreground: Color red ] ];
		send: #version
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> gtRPackages [
	| gtRPackages |
	gtRPackages := OrderedCollection new.
	self packages do: [:each | 
		(self packageOrganizer includesPackageNamed: each name) ifTrue: [
			gtRPackages add: (self packageOrganizer packageNamed: each name)] ].
	^ gtRPackages
]

{ #category : #'*GToolkit-Inspector' }
MetacelloVersion >> hash [
	<gtPharoPatch: #Pharo>
	"needed because the super implementation only checks the version number,
	and we also need to ensure that we have the same configuration class"

	^ (self 
		forPharo12: [ self identityHash] 
		forPharo11AndPharo10: [ self versionNumber hash]) 
			bitXor: self spec project configuration class hash
]
