api - instantiation
create
	| aRadius aThickness |

	aRadius := self radius.
	aThickness := self thickness.

	^ BlElement new
		size: (aRadius + aRadius) @ (aRadius + aRadius);
		geometry: (BlPolygon vertices: { 
			(aRadius - aThickness)@0 . (aRadius + aThickness)@0 . (aRadius + aThickness)@(aRadius - aThickness). (aRadius + aRadius)@(aRadius - aThickness). (aRadius + aRadius)@(aRadius + aThickness). (aRadius + aThickness)@(aRadius + aThickness). (aRadius + aThickness)@(aRadius + aRadius). (aRadius - aThickness)@(aRadius + aRadius). (aRadius - aThickness)@(aRadius + aThickness). 0@(aRadius + aThickness). 0@(aRadius - aThickness). (aRadius - aThickness)@(aRadius - aThickness)} );
		background: Color gray;
		transformDo: [ :t | t rotateBy: self angle ]