Extension { #name : #MetacelloMCVersion }

{ #category : #'*GToolkit-Inspector' }
MetacelloMCVersion >> = aMetacelloVersion [
	"needed because the super implementation only checks the version number,
	and we also need to ensure that we have the same configuration class"	
	^ (super = aMetacelloVersion) and: [ 
		self spec project configuration class = aMetacelloVersion spec project configuration class ]
]

{ #category : #'*GToolkit-Inspector' }
MetacelloMCVersion >> gtDisplayOn: stream [
	stream nextPutAll: self spec project configuration class name
]

{ #category : #'*GToolkit-Inspector' }
MetacelloMCVersion >> gtRPackages [
	| gtRPackages |
	gtRPackages := OrderedCollection new.
	self packages do: [:each | 
		(RPackageOrganizer default includesPackageNamed: each name) ifTrue: [
			gtRPackages add: (RPackageOrganizer default packageNamed: each name)] ].
	^ gtRPackages
]

{ #category : #'*GToolkit-Inspector' }
MetacelloMCVersion >> hash [
	"needed because the super implementation only checks the version number,
	and we also need to ensure that we have the same configuration class"

	^ super hash bitXor: self spec project configuration class hash
]
