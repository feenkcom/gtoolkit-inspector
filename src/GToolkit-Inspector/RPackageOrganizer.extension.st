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

{ #category : #'*GToolkit-Inspector' }
RPackageOrganizer >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ classPackageMapping gtSpecificSizeInMemory
		+ packages gtSpecificSizeInMemory
		+ (packages sum: #gtSpecificSizeInMemory)
		+ classExtendingPackagesMapping gtSpecificSizeInMemory
		+ (classExtendingPackagesMapping sum: #gtSpecificSizeInMemory)
		+ packageNames gtSpecificSizeInMemory
]
