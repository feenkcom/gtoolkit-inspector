Extension { #name : #BlMorphicWorldEmbeddingElement }

{ #category : #'*GToolkit-Inspector' }
BlMorphicWorldEmbeddingElement class >> openEmbedded [
	<script: 'self openEmbedded'>
	GtPager
		openWrappedOn: self new beMain
		title: 'Morph World'
]
