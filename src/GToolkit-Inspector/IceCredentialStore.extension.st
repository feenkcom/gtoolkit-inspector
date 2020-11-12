Extension { #name : #IceCredentialStore }

{ #category : #'*GToolkit-Inspector' }
IceCredentialStore >> gtAllCredentialsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'All Credentials';
		items: [ self allCredentials ];
		column: 'Host' item: #hostDescription weight: 1;
		column: 'Type' item: #type weight: 1;
		column: 'Description' item: #description weight: 5;
		column: 'Remove' icon: [ :aCredential |
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousVectorIcons remove;
				label: 'Remove credential';
				action: [ :aButton | 
					self removeCredential: aCredential. ] ]
]

{ #category : #'*GToolkit-Inspector' }
IceCredentialStore >> gtRemoveStoreFileFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons remove;
		tooltip: 'Remove credentials file';
		action: [ storeFile asFileReference ensureDelete ]
]
