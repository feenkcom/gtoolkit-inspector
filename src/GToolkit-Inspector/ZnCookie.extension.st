Extension { #name : #ZnCookie }

{ #category : #'*GToolkit-Inspector' }
ZnCookie >> gtCookieFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Cookie';
		priority: 40;
		items: [ {
			{ 'domain' . self domain }.
			{ 'path' . self path }.
			{ 'secure' 
				. self secure gtColoredText 
				. self secure }.
			{ 'httponly' 
				. self httponly gtColoredText 
				. self httponly }.
			{ 'expires' 
				. self expires ifNil: [ '' ]
				.  self expiresTimeStamp }.
			{ 'expired' 
				. self isExpired gtColoredText
				. self isExpired }.
			{ 'name' . self name }.
			{ 'value' . self value }
		} ];
		column: 'Key' text: #first;
		column: 'Value' text: #second weight: 3;
		send: #last
]
