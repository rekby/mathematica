My library with Wolfram Mathematica (WM) functions.

It is my first expierence with WM and code can change often, may contain many errors and use not ideomatic way or reinventing the wheel.

## Build

```wolfram
dir = "<project dir>"

tmp = CreateDirectory[]

CopyDirectory[FileNameJoin[{dir, "FindFacesWithImageRotations"}], tmp]

CopyFile[FileNameJoin[{dir, "PacletInfo.m"}], FileNameJoin[{tmp, "PacletInfo.m"}]]

paclet = CreatePacletArchive[tmp, dir]

DeleteDirectory[tmp, DeleteContents -> True]
```

## Install

`paclet` - file _.paclet_ from the web or local file system

```wolfram
PacletInstall[paclet]
```

## Using 

```wolfram
<<FindFacesWithImageRotations`

FindFacesWithImageRotations[Import["https://wolfr.am/15wRbbzZ9"]]
```