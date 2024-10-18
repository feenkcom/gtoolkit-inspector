Extension { #name : #MCOrganizationDefinition }

{ #category : #'*GToolkit-Inspector' }
MCOrganizationDefinition >> gtViewCategoriesIn: aView [
	<gtView>
	^ aView list
		title: 'Categories';
		priority: 20;
		items: [ self categories ]
]
