Needs["Rekby`"]
PrependTo[$ContextPath,"Rekby`Private`"]

VerificationTest[RekbyPackagePing[], True, TestID->"RekbyPackagePing"]
VerificationTest[Rekby`RekbyPackagePing[], True, TestID->"RekbyPackagePing-ForcePublicNamespace"]


VerificationTest[
	facesPartCoordinatesTransformQ[Rectangle[]] == True &&
	facesPartCoordinatesTransformQ[{}] == False &&
	facesPartCoordinatesTransformQ[{{}}] == False &&
	facesPartCoordinatesTransformQ[{1.}] == False &&
	facesPartCoordinatesTransformQ[{1., 2.}] == True &&
	facesPartCoordinatesTransformQ[{{1., 2.}}] == True &&
	True,
	TestID->"facesPartCoordinatesTransformQ"
]


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
    ]

