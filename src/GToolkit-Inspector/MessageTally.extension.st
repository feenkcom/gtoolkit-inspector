Extension { #name : #MessageTally }

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtMessagesTreeIn: aView [
	<gtView>
	| methods normalizer |
	methods := self withDeepCollect: #children.
	normalizer := BrColorLinearNormalizer 
						inContext: methods 
						withCommand: #tally 
						lowColor: Color gray 
						highColor: Color red.
	^ (aView tree)
		title: 'Tree';
		priority: 10;
		items: [ { self } ];
		children: [ :each | each children ];
		itemFormat: [ :each | 
			each gtDisplayString asRopedText foreground: (normalizer value: each)]		
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtSourceFor: aView [
	<gtView>
	^ self method ifNotNil: [
		(self method gtSourceFor: aView) priority: 20]
]

{ #category : #'*GToolkit-Inspector' }
MessageTally >> gtTextReportFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Text report';
		look: BrGlamorousCodeEditorLook new;
		priority: 60;
		text: [ String streamContents: [:s | self report: s ] ]
]
