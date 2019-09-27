Extension { #name : #ZnStatusLine }

{ #category : #'*GToolkit-Inspector' }
ZnStatusLine >> gtHttpFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTTP';
		priority: 30;
		text: [ (String streamContents: [ :out | self writeOn: out ]) asRopedText ]
]
