Needs["Rekby`"]
PrependTo[$ContextPath,"Rekby`Private`"]

VerificationTest[RekbyPackagePing[], True, TestID->"RekbyPackagePing"]
VerificationTest[Rekby`RekbyPackagePing[], True, TestID->"RekbyPackagePing-ForcePublicNamespace"]

VerificationTest[
	deduplicateFaces[{ 
		Rectangle[{0,0}, {1,1}], 
		Rectangle[{1,1}, {2,2}], 
		Rectangle[{0,0}, {1,1}], (* filtered same size *) 
		Rectangle[{3,3}, {5,5}], (* replaced with next, smaller area *)
		Rectangle[{3,3}, {4,4}],
		Rectangle[{3,3}, {6,6}]  (* filtered besause has same with smaller area *) 
	}],
	{
		Rectangle[{0,0}, {1,1}],
		Rectangle[{1,1}, {2,2}], 
		Rectangle[{3,3}, {4,4}]
	},
	TestID->"deduplicateFaces"
]

VerificationTest[
	faceBetter[ <|"a" -> 2, "BoundingBox"->Rectangle[{0,0}, {1,1}] |>, <|"a" -> 1, "BoundingBox"->Rectangle[{0,0}, {2,2}] |> ] == <|"a" -> 2, "BoundingBox"->Rectangle[{0,0}, {1,1}] |>,
	TestID->"faceBetter, BoundingBox"
]

VerificationTest[
	faceWithSamePlaceQ[ Polygon[{{0, 0}, {1, 0}, {0, 1}}], Rectangle[{0.5, 0}, {1, 1}] ] == False &&
	faceWithSamePlaceQ[ Polygon[{{0, 0}, {1, 0}, {0, 1}}], Rectangle[{0.0, 0}, {1, 1}] ] == True &&
	faceWithSamePlaceQ[ Polygon[{{0, 0}, {1, 0}, {0, 1}}], Rectangle[{1.0, 1}, {2, 2}] ] == False,
	TestID->"faceWithSamePlaceQ, Polygon"
];

VerificationTest[
	faceWithSamePlaceQ[ <| "BoundingBox"->Polygon[{{0, 0}, {1, 0}, {0, 1}}] |>, <| "BoundingBox"->Rectangle[{0.5, 0}, {1, 1}] |> ] == False &&
	faceWithSamePlaceQ[ <| "BoundingBox"->Polygon[{{0, 0}, {1, 0}, {0, 1}}] |>, <| "BoundingBox"->Rectangle[{0.0, 0}, {1, 1}] |> ] == True &&
	faceWithSamePlaceQ[ <| "BoundingBox"->Polygon[{{0, 0}, {1, 0}, {0, 1}}] |>, <| "BoundingBox"->Rectangle[{1.0, 1}, {2, 2}] |> ] == False,
	TestID->"faceWithSamePlaceQ, Association"
];

VerificationTest[
	faceBetter[ Rectangle[{0,0}, {1,1}], Rectangle[{0,0}, {2,2}] ] == Rectangle[{0,0}, {1,1}],
	TestID->"faceBetter, polygons"
];

VerificationTest[
	faceBetter[ <|"a" -> 2, "Strength"->0.1|>, <|"a" -> 1, "Strength"->0.2|> ] == <|"a" -> 1, "Strength"->0.2|>,
	TestID->"faceBetter, strength"
];

VerificationTest[
	facesPartCoordinatesTransformQ[Rectangle[]] == True &&
	facesPartCoordinatesTransformQ[{}] == False &&
	facesPartCoordinatesTransformQ[{{}}] == False &&
	facesPartCoordinatesTransformQ[{1.}] == False &&
	facesPartCoordinatesTransformQ[{1., 2.}] == True &&
	facesPartCoordinatesTransformQ[{{1., 2.}}] == True &&
	True,
	TestID->"facesPartCoordinatesTransformQ"
];

VerificationTest[
  polygonCoordinatesOrdered[
    Polygon[{{1, 1}, {2, 2}}]],
    {{1,1},{2,2}},
    TestID->"PolygonCoordinatesOrdered-Simple"
];
    
VerificationTest[
    polygonCoordinatesOrdered[
    	Polygon[{{1, 1}, {1, 2}, {2, 1}, {2, 2}}, {1, 3, 4, 2}]
    ],
    {{1,1},{2,1},{2,2},{1,2}},
    TestID->"PolygonCoordinatesOrdered-Point-Order"
];
    
VerificationTest[
	polygonWithSamePlaceQ[ Polygon[{{0, 0}, {1, 0}, {0, 1}}], Rectangle[{0.5, 0}, {1, 1}] ] == False &&
	polygonWithSamePlaceQ[ Polygon[{{0, 0}, {1, 0}, {0, 1}}], Rectangle[{0.0, 0}, {1, 1}] ] == True &&
	polygonWithSamePlaceQ[ Polygon[{{0, 0}, {1, 0}, {0, 1}}], Rectangle[{1.0, 1}, {2, 2}] ] == False
	,
	TestID->"polygonWithSamePlace"
];
