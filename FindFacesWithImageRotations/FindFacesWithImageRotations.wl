(*::Package::*)


BeginPackage["FindFacesWithImageRotations`"];


FindFacesWithImageRotations::usage = 
"FindFacesWithImageRotations[img]
FindFacesWithImageRotations[img, prop] 
Use as FaceRecognize, but the function rotate the image for recognize more faces"


Begin["`Private`"];


FindFacesWithImageRotations[img_] := Module[
	{findFaces},
	findFaces[findImg_] := FindFaces[findImg];
	
	findFacesWithImageRotations[img, findFaces]
];


FindFacesWithImageRotations[img_, prop_] := Module[
	{findFaces},
	findFaces[findImg_] := FindFaces[findImg, prop];
	findFacesWithImageRotations[img, findFaces]
];	


FindFacesWithImageRotations[img_, crit_, prop_] := Module[
	{findFaces},
	findFaces[findImg_] := FindFaces[findImg, crit, prop];
	findFacesWithImageRotations[img, findFaces]
];	


findFacesWithImageRotations[img_, findFaces_] :=
deduplicateFaces@Join[
	findFacesWithImageRotations[img, findFaces, 0],
	findFacesWithImageRotations[img, findFaces, Pi/2],
	findFacesWithImageRotations[img, findFaces, Pi],
	findFacesWithImageRotations[img, findFaces, -Pi/2]
];


findFacesWithImageRotations[img_, findFaces_, angle_] := Module[
	{faces, fixFace, fixValue, rotatedImage, transformation, rotate, move},
	rotatedImage = ImageRotate[img, angle, All];
	faces = findFaces[rotatedImage];
		
	rotate = RotationTransform[-angle, ImageDimensions[rotatedImage]/2];	
	move = TranslationTransform[ -(ImageDimensions[rotatedImage]-ImageDimensions[img]) / 2];
		
	transformation = RightComposition[rotate, move];
		
	fixValue[item_] := Switch[
		item,
		_Association, fixValue /@ item,
		(*_Image, ImageRotate[item, -angle],*)
		_ /; facesPartCoordinatesTransformQ[item], transformation@item,
		_, item
	];
		
	fixFace[item_] := If[
		AssociationQ[item],
		fixValue /@ item,
		fixValue[item]
	];
		
	fixFace /@ faces
]


facesPartCoordinatesTransformQ[item_] := Switch[
	item,
	_Rectangle, True,
	List[_Real, _Real], True, (* Coordinates: {1.0, 2.0} *)
	_List /; Length@item > 0 && Count[item, Except[{_Real,_Real}]] == 0, True, (* List of coordinates: { {1.0, 2.0}, {3.0, 4.0} } *)
	_, False		
];


deduplicateFaces[list_List] := 
Fold[
	With[{ inputList=#1, face=#2, firstPosition=FirstPosition[#1, item_ /; faceWithSamePlaceQ[item, #2] ][[1]] },			
		If[ firstPosition === "NotFound",
			Append[inputList, face],
			ReplacePart[inputList, firstPosition -> faceBetter[ inputList[[firstPosition]], face ] ]
		]
	]&,
	{}, list
];


keyPattern[key_String] := <|___, _[key, _], ___|>


faceWithSamePlaceQ[a_?SimplePolygonQ, b_?SimplePolygonQ] := 
polygonWithSamePlaceQ[a,b];


faceWithSamePlaceQ[a: keyPattern["BoundingBox"], b: keyPattern["BoundingBox"]] := 
polygonWithSamePlaceQ[a[["BoundingBox"]], b[["BoundingBox"]]];


polygonWithSamePlaceQ[p1_, p2_] := 
Min[Area[p1], Area[p2]] * 0.5 < Area[RegionIntersection[p1, p2]];


faceBetter[a_?SimplePolygonQ, b_?SimplePolygonQ] := 
MinimalBy[{a, b}, Area][[1]];


faceBetter[a: keyPattern["Strength"], b: keyPattern["Strength"]] := 
MaximalBy[{a,b}, #[["Strength"]] & ][[1]];


faceBetter[a: keyPattern["BoundingBox"], b: keyPattern["BoundingBox"]] := 
MinimalBy[{a,b}, Area[#[["BoundingBox"]]]&][[1]];


polygonCoordinatesOrdered[p_ /; Head[p] == Polygon && Length@p == 1 && Count[p[[1]], Except[_List]] == 0] := 
p[[1]];


polygonCoordinatesOrdered[p_ /; Head[p] == Polygon && Length@p == 2 && Count[p[[1]], Except[_List]] == 0 && Count[ p[[2]], Except[_Integer]] == 0] := 
p[[1]][[#]] & /@ p[[2]]; 

 	  
End[]; (*`Private`*)


EndPackage[]; (*FindFacesWithImageRotations`*)

