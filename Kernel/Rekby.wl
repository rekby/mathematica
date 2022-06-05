BeginPackage["Rekby`"];

RekbyPackagePing::usage = "Check about package imported succesfully";
FindFacesWithImageRotations::usage = "Use as FaceRecognize, but the function rotate the image for recognize more faces"

Begin["`Private`"];
	RekbyPackagePing[] := True
	
	facesPartCoordinatesTransformQ[item_] := Switch[
		item,
		_Rectangle, True,
		List[_Real, _Real], True, (* Coordinates: {1.0, 2.0} *)
		_List /; Length@item > 0 && Count[item, Except[{_Real,_Real}]] == 0, True, (* List of coordinates: { {1.0, 2.0}, {3.0, 4.0} } *)
		_, False		
	];

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
	
	findFacesWithImageRotations[img_, findFaces_] := Module[
		{aa},
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
			_Image, ImageRotate[item, -angle],
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
	
 	polygonCoordinatesOrdered[ p_ /; Head[p] == Polygon && Length@p == 1 && Count[ p[[1]], Except[_List]] == 0 ] := p[[1]];
  	polygonCoordinatesOrdered[ p_ /; Head[p] == Polygon && Length@p == 2 && Count[ p[[1]], Except[_List]] == 0 && Count[ p[[2]], Except[_Integer]] == 0 ] := p[[1]][[#]] & /@ p[[2]];  
  
End[];
EndPackage[];

