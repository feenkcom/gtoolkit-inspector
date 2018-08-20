*GToolkit-Inspector
gtResponseFor: aView
	<gtView>
	^ self statusLine 
		ifNotNil: [ :aStatusLine | 
			(aStatusLine gtHttpFor: aView)
				title: 'Response';
				priority: 25 ] 
		ifNil: [ aView empty ]