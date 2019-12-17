Class {
	#name : #GtIceberg,
	#superclass : #Object,
	#category : #'GToolkit-Inspector'
}

{ #category : #inspecting }
GtIceberg >> gtRegistryFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Registry';
		priority: 5;
		items: [ IceRepository registry sorted: [ :a :b | a name asLowercase < b name asLowercase ] ];
		column: 'Name' do: [ :aColumn | 
			aColumn 
				itemFormat: [ :repository | repository name asString ];
				matchParent ];
		column: 'Status' do: [ :aColumn | 
			aColumn 
				itemFormat: [ :repository | (IceTipRepositoryModel on: repository) status ];
				matchParent ];
		column: 'Branch' do: [ :aColumn | 
			aColumn 
				itemFormat: [ :repository | (IceTipRepositoryModel on: repository) branchName ];
				matchParent ]
	

]
