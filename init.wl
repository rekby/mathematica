(* ::Package:: *)

BeginPackage["Rekby`"];
RekbyPackagePing = True;

Begin["`Private`"];
  PolygonCoordinatesOrdered[p_ /; Head[p] == Polygon && Length@p == 1] := p[[1]];
  PolygonCoordinatesOrdered[p_ /; Head[p] == Polygon && Length@p == 2] := p[[1]][[#]] & /@ p[[2]];
End[];
EndPackage[];

