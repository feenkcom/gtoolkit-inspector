Extension { #name : #ClassAnnotationRegistry }

{ #category : #'*GToolkit-Inspector' }
ClassAnnotationRegistry >> gtViewAnnotatedClassesFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Annotated classes';
		priority: 5;
		object: [ annotatedClasses ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Inspector' }
ClassAnnotationRegistry >> gtViewAnnotationsFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Annotations';
		priority: 10;
		object: [ annotations ];
		view: #gtItemsFor:
]
