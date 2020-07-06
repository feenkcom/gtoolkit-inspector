Extension { #name : #BlAffineTransformation }

{ #category : #'*GToolkit-Inspector' }
BlAffineTransformation >> gtMatrixFor: aView [
	<gtView>
	
	^ self asMatrix gtMatrixFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlAffineTransformation >> gtPreviewFor: aView [
	<gtView>
	self is2D ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Preview';
		stencil: [
			| canvas aHouse |
			canvas := Bloc preferableSpartaCanvas extent: 500@500.
			aHouse := canvas path
				relative;	
				"house"
				moveTo: 70@0;
				lineTo: 70@60;
				lineTo: 20 negated @ 0;
				lineTo: 0@115;
				lineTo: 100 negated @ 0;
				lineTo: 0@115 negated;
				lineTo: 100@0;
				moveTo: 100 negated @ 0;
				lineTo: 20 negated @ 0;
				lineTo: 70@60 negated;
				"window"
				moveTo: 35 negated @ 80;
				lineTo: 30@0;
				lineTo: 0@30;
				lineTo: 30 negated @ 0;
				lineTo: 0@30 negated;
				"door"
				moveTo: 40 @ 95;
				lineTo: 0 @ 50 negated;
				lineTo: 25 @ 0;
				lineTo: 0 @ 50;
				build.
			canvas fill
				paint: Color white;
				path: canvas bounds;
				draw.
			canvas transform
				translateBy: 50@50;
				push.
			canvas stroke
				paint: Color black;
				path: aHouse;
				width: 2;
				dashPattern: #(4 4);
				draw.
			canvas transform
				multiplyBy: self asMatrix;
				push.
			canvas stroke
				paint: Color black;
				path: aHouse;
				width: 2;
				draw.
			canvas transform pop pop.
			canvas asForm asElement ]
]
