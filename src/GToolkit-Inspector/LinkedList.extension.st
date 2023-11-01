Extension { #name : #LinkedList }

{ #category : #'*GToolkit-Inspector' }
LinkedList >> gtItemsFor: aView [
	"Display the items for the receiver.
	Since a columnedList uses a linked list for holding its items we have to:
	- not supply them as a LinkedList to avoid recursion
	- wrap the individual items to avoid the item's nextLink being corrupted"
	<gtView>
	^ aView forward
		title: 'Items';
		priority: 50;
		object: [ self asArray collect: [ :each |
			ValueLink value: each ] ];
		view: #gtItemsFor:;
		actionUpdateButtonTooltip: 'Update item list'
]
