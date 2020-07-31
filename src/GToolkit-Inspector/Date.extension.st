Extension { #name : #Date }

{ #category : #'*GToolkit-Inspector' }
Date >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ {('iso' -> self yyyymmdd).
			('year' -> self year).
			('month' -> self monthIndex).
			('month name' -> self monthName).
			('day of month' -> self dayOfMonth).
			('day of week' -> self dayOfWeekName).
			('day of year' -> self dayOfYear)} ];
		column: 'Key' item: #key;
		column: 'Value' item: #value;
		send: #value
]
