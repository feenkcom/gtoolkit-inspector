Extension { #name : #Interval }

{ #category : #'*GToolkit-Inspector' }
Interval >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		priority: 60;
		items: [ {
			{ #start . start }.
			{ #stop . stop }.
			{ #step . step }.
			{ #size . self size } } ];
		column: #key text: #first weight: 0.5;
		column: #value text: #second
]
