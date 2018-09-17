Class {
	#name : #GtInspectorRoundButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'size'
	],
	#category : 'GToolkit-Inspector-Stencils'
}

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> large [
	^ self new size: 24@24
]

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> normal [
	^ self new size: 20@20
]

{ #category : #'instance creation' }
GtInspectorRoundButtonStencil class >> small [
	^ self new size: 16@16
]

{ #category : #'api - instantiation' }
GtInspectorRoundButtonStencil >> create [
	^ BrButton new
		background: Color white;
		look: BrIconLook + BrGlamorousFocusableShadowLook new;
		geometry: BlEllipse new;
		layout: BlLinearLayout horizontal alignCenter;
		size: self size;
		when: BlMouseEnterEvent do: [ :anEvent | anEvent currentTarget background: Color veryVeryLightGray lighter ];
		when: BlMouseLeaveEvent do: [ :anEvent | anEvent currentTarget background: Color white ];
		yourself
]

{ #category : #initialization }
GtInspectorRoundButtonStencil >> initialize [
	super initialize.
	
	size := 20@20
]

{ #category : #accessing }
GtInspectorRoundButtonStencil >> size [
	^ size
]

{ #category : #accessing }
GtInspectorRoundButtonStencil >> size: anObject [
	size := anObject
]
