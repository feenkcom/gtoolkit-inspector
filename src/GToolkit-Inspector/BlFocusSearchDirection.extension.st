Extension { #name : 'BlFocusSearchDirection' }

{ #category : '*GToolkit-Inspector' }
BlFocusSearchDirection >> gtArrowElementAt: aPoint [
	<return: #BlElement>
	
	^ BlLineElement new
		fromAnchor: (BlAbsolutePositionAnchor position: aPoint);
		toAnchor: (BlAbsolutePositionAnchor position: aPoint + (self vector * 20) asPoint);
		toHead: (BlArrowheadSimpleArrow new
			arrowLengthFraction: 3;
			arrowNoseAngle: 45;
			border: (BlBorder paint: Color red width: 2));
		border: (BlBorder paint: Color red width: 2);
		yourself
]
