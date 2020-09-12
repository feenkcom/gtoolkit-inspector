Extension { #name : #RPackageOrganizer }

{ #category : #'*GToolkit-Inspector' }
RPackageOrganizer >> gtPackagesFor: aView [
	<gtView>
	self packages ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Packages';
		items: [ self packages sorted ];
		itemText: #name
]
