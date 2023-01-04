Extension { #name : #IceLogVersion }

{ #category : #'*GToolkit-Inspector' }
IceLogVersion >> gtCommentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Comment';
		priority: 5;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self comment ]
]

{ #category : #'*GToolkit-Inspector' }
IceLogVersion >> gtSourceFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Source';
		priority: 1;
		styler: BrRBTextStyler new;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self source ]
]

{ #category : #'*GToolkit-Inspector' }
IceLogVersion >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 0;
		items: [ {'Comment' -> self comment.
				'Time' -> self datetime. 
				'Definition' -> self definition.
				'Author' -> self author.
				'Commit' -> self commit} ];
		column: 'Property' text: #key;
		column: 'Value' text: [:each | each value gtDisplayString];
		send: #value
]
