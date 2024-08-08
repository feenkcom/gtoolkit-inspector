Class {
	#name : #GtInspectorStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Inspector-Scripter'
}

{ #category : #'steps - interactions' }
GtInspectorStep >> clickOnInspectButton [
	^ self click
		referenceSender;
		label: 'Click on play and inspect button';
		// GtInspectorInspectButtonId
]

{ #category : #'steps - interactions' }
GtInspectorStep >> dragPlaygroundVerticallyBy: aNumber [
	^ (self mouseDragBy: 0 @ aNumber)
		label: ('Drag inspector playground by {1}' format: { aNumber });
		referenceSender;
		// LeInspectorPlaygroundResizerId
]
