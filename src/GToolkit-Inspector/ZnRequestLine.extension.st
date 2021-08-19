Extension { #name : 'ZnRequestLine' }

{ #category : '*GToolkit-Inspector' }
ZnRequestLine >> gtViewRequestLineTextFor: aView [
	<gtView>
	^ aView text
		title: 'HTTP';
		text: [ String streamContents: [ :out | self writeOn: out ] ]
]
