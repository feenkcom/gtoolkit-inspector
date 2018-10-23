Extension { #name : #ZipArchive }

{ #category : #'*GToolkit-Inspector' }
ZipArchive >> gtMembersFor: aView [
	<gtView>
	^ aView list 
		title: 'Members';
		items: self members
]
