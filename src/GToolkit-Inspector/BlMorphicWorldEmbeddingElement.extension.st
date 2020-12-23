Extension { #name : #BlMorphicWorldEmbeddingElement }

{ #category : #'*GToolkit-Inspector' }
BlMorphicWorldEmbeddingElement classSide >> openEmbedded [
	<script: 'self openEmbedded'>
	GtPager
		openWrappedOn: self new beMain
		title: 'Morph World'
]
