Extension { #name : 'BlExtentMeasurementSpec' }

{ #category : '*GToolkit-Inspector' }
BlExtentMeasurementSpec >> gtSpecFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Spec';
		items: [ { 'width' -> self widthSpec . 'height' -> self heightSpec } ];
		send: #value;
		column: 'Dimension' text: [ :each | each key ];
		column: 'Size' text: [ :each | each value ]
]
