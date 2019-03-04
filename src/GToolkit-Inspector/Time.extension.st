Extension { #name : #Time }

{ #category : #'*GToolkit-Inspector' }
Time >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ {('iso' -> self print24).
			('hours' -> self hours).
			('minutes' -> self minutes).
			('seconds' -> self seconds).
			('nanoseconds' -> self nanoSecond).
			('meridian' -> self meridianAbbreviation)} ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value
]
