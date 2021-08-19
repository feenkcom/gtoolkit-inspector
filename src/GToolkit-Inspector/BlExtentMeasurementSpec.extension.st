Extension { #name : 'BlExtentMeasurementSpec' }

{ #category : '*GToolkit-Inspector' }
BlExtentMeasurementSpec >> gtSpecFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Spec';
		items: [ { 'width' -> self widthSpec . 'height' -> self heightSpec } ];
		send: #value;
		column: 'Dimension' item: [ :each | each key ];
		column: 'Size' item: [ :each | each value ]
]
