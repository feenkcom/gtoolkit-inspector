Extension { #name : #VirtualMachine }

{ #category : #'*GToolkit-Inspector' }
VirtualMachine >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 10;
		items: [ {('VM directory' -> self directory asFileReference).
			('VM build date' -> self buildDate).
			('VM version' -> self version).
			('Image directory' -> self imagePath asFileReference parent).
			('Image version' -> self imageVersionNumber)} ];
		column: 'Property' text: [:assoc | assoc key ];
		column: 'Value' text: [:assoc | assoc value gtDisplayString ];
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
VirtualMachine >> gtParametersFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Parameters';
		priority: 20;
		items: [ {
			('Eden' -> (self parameterAt: 44) humanReadableSIByteSize).
			('Machine Code' -> (self parameterAt: 46) humanReadableSIByteSize).
			('Memory Threshold' -> (self parameterAt: 24) humanReadableSIByteSize).
			('Memory Headroom' -> (self parameterAt: 25) humanReadableSIByteSize).
			('GC Growth / Image ratio' -> ((self parameterAt: 55) printShowingDecimalPlaces: 2)).
			('Stack Page count' -> (self parameterAt: 42)).
			('Max Old Space' -> 
				((self parameterAt: 67) = 0
					ifTrue: ['unlimited']
					ifFalse: [(self parameterAt: 67) humanReadableSIByteSize])).
			} ];
		column: 'Property' text: [:assoc | assoc key ];
		column: 'Value' text: [:assoc | assoc value gtDisplayString ];
		send: #value
]

{ #category : #'*GToolkit-Inspector' }
VirtualMachine >> gtStatisticsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Statistics';
		priority: 30;
		actionUpdateButton;
		items: [ {('Full GC count' -> (self parameterAt: 7)).
			('Scavenge count' -> (self parameterAt: 8)).
			('Tenure count' -> (self parameterAt: 11)).
			('Grow Memory Request count' -> (self parameterAt: 31)).
			('Shrink Memory Request count' -> (self parameterAt: 32)).
			('Segment count' -> (self parameterAt: 53)).
			('Free Old Space' -> (self parameterAt: 54) humanReadableSIByteSize).
			('Average Live Stack Pages' -> (self parameterAt: 68) rounded).
			('Max. Live Stack Pages' -> (self parameterAt: 69)).
			('Stack Page Overflows' -> (self parameterAt: 60)).
			('Stack Page Divorces' -> (self parameterAt: 61)).
			} ];
		column: 'Property' text: [:assoc | assoc key ];
		column: 'Value' text: [:assoc | assoc value gtDisplayString ];
		send: #value
]
