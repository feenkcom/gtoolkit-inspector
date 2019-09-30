Extension { #name : #VirtualMachine }

{ #category : #'*GToolkit-Inspector' }
VirtualMachine >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ {('VM directory' -> self directory asFileReference).
			('VM build date' -> self buildDate).
			('VM version' -> self version).
			('Image directory' -> self imagePath asFileReference parent).
			('Image version' -> self imageVersionNumber)} ];
		column: 'Property' do: [ :aColumn | aColumn item: [:assoc | assoc key ] ];
		column: 'Value' do: [ :aColumn | aColumn item: [:assoc | assoc value gtDisplayString ]  ];
		send: #value
]
