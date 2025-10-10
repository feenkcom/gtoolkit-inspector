Extension { #name : #PackageOrganizer }

{ #category : #'*GToolkit-Inspector' }
PackageOrganizer >> gtPackagesFor: aView [
	<gtView>
	self packages ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Packages';
		items: [ self packages sorted ];
		itemText: #name
]

{ #category : #'*GToolkit-Inspector' }
PackageOrganizer >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ packages gtSpecificSizeInMemory
		+ (packages sumNumbers: [:each | each gtSpecificSizeInMemory])
]
