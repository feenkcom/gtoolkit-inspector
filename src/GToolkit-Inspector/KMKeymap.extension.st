Extension { #name : #KMKeymap }

{ #category : #'*GToolkit-Inspector' }
KMKeymap >> gtDisplayOn: aStream [
	aStream 
		nextPutAll: self name displayString;
		nextPutAll: ' on ';
		nextPutAll: self shortcut displayString;
		nextPutAll: ' do ' ;
		nextPutAll: self action displayString
]
