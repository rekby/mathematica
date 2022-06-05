(* ::Package:: *)

If[MemberQ[$ContextPath, "Rekby`"],
    Remove["Rekby`Private`*", "Rekby`*"]
]

Get[FileNameJoin[{NotebookDirectory[], "init.wl"}]]

Once[PrependTo[$ContextPath, "Rekby`Private`"]]


VerificationTest[RekbyPackagePing, True]


VerificationTest[
  PolygonCoordinatesOrdered[
    Polygon[{{1, 1}, {2, 2}}]],
    {{1,1},{2,2}}
    ];
    
    VerificationTest[
    PolygonCoordinatesOrdered[
    CanonicalizePolygon[Rectangle[{1,1}, {2,2}]]
    ],
    {{1,1},{2,1},{2,2},{1,2}}
    ]



