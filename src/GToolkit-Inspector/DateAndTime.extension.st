Extension { #name : #DateAndTime }

{ #category : #'*GToolkit-Inspector' }
DateAndTime >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		items: [ {('iso' -> self printString).
			('utc' -> self asUTC).
			('year' -> self year).
			('month' -> self monthIndex).
			('month name' -> self monthName).
			('day of month' -> self dayOfMonth).
			('day of week' -> self dayOfWeekName).
			('day of year' -> self dayOfYear).
			('hours' -> self hours).
			('minutes' -> self minutes).
			('seconds' -> self seconds).
			('nanoseconds' -> self nanoSecond).
			('meridian' -> self meridianAbbreviation).
			('offset' -> self offset).
			('date' -> self asDate).
			('time' -> self asTime)} ];
		column: 'Key' item: #key;
		column: 'Value' item: #value;
		send: #value
]
