

(*
$DisplayFunction = Identity;
*)


Clear[dof,nof];
nof = $Input;
dof = MyDateConv[FileDate[nof]];
dof = StringJoin[
  ToString[dof[[3]]], ".",
  ToString[dof[[2]]], ".",
  ToString[dof[[1]]], " ",
  ToString[dof[[4]]], ":",
  ToString[dof[[5]]], ":",
  ToString[dof[[6]]]];
Print["    ",nof,"        ",dof,"    (",FileByteCount[nof]," Bytes)"];
Clear[dof,nof];



Off[General::"spell"];
Clear[
    ExifData,
    FromCloneFileName,
    MainFileName,
    PreComputeExifData,
    ReadQRCode,
    ToCloneFileName,
    UsePreComputedExifData,
    WriteQRCode];
On[General::"spell"];



UsePreComputedExifData = True;



ExifData[fname_] := Module[{c, f, h, X},
   If[MemberQ[{".BMP", ".GIF", ".TGA"}, ToUpperCase[FSplit[fname][[3]]]], Return[{}]];
   If[Not[TrueQ[FileType[fname] === File]], Return[1]];
   If[TrueQ[UsePreComputedExifData],
     If[TrueQ[FileType[h = StringJoin[fname, "_ExifData.txt"]] === File],
      h = Check[Get[h], -1];
      If[Not[TrueQ[h === -1]],
       Return[h]]]];
   h = DirectoryName[fname];
   While[DirectoryStack[] != {}, ResetDirectory[]];
   SetDirectory[h];
   SetDirectory[h];
   f = {"el.bat", "exiflist.txt"};
   Off[DeleteFile::fdnfnd];
   DeleteFile /@ f;
   On[DeleteFile::fdnfnd];
   If[Not[f[[1]] === Export[f[[1]],
       {"chcp 1252",
        StringJoin["exiflist /o dn \"", BareName[fname], "\" >> ", 
         f[[2]]]},
       "Lines"]],
    Return[2]];
   If[Run[f[[1]]] != 0, Return[3]];
   h = StringJoin[h, f[[2]]];
   X = Check[Import[h, "Lines"], Null];
   If[Not[TrueQ[ListQ[X]]],
    X = Check[Import[h, "Lines"], Null]];
   If[Not[TrueQ[ListQ[X]]], Return[4]];
   DeleteFile /@ f;
   ResetDirectory[];
   f = Join @@ Position[StringLength[X], 0];
   f = Transpose[
     {Prepend[f + 1, 1                     ],
        Append[f - 1, Length[X]]}];
   X = Map[Take[X, #] &, f];
   If[Length[X[[1]]] != 1, Return[5]];
   If[Not[TrueQ[StringDrop[X[[1, 1]], 6] === BareName[fname]]], 
    Return[6]];
   X = Drop[X, 1];
   If[X==={}, Return[{}]];
   X = Transpose[Map[{{StripChar[#[[1]], " "]}, Drop[#, 1]}&, X]];
   X[[2]] = Map[
     If[     
       StringTake[#,               34] === 
        "                                  ",      {StringDrop[#, 34]},
       If[
        StringTake[#, {33, 34}] === 
         ": ", {StripChar[StringTake[#, 32], " "], StringDrop[#, 34]},
        {}]] &,
     X[[2]], {2}];
   If[Not[
     Complement[Flatten[Map[Length, X[[2]], {2}]], {1, 2}] === {}], 
    Return[7]];
   X[[2]] = Map[(
       h = #;
       c = Join @@ Position[Append[Length /@ h, 2], 2];
       If[c[[1]] != 1, Return[8]];
       c = Transpose[{Drop[c, -1], Drop[c, 1] - 1}];
       h = Join @@@ Map[Take[h, #] &, c];
       Map[{#[[1]], StringJoin @@ Drop[#, 1]} &, h]) &,
     X[[2]]];
   X = Prepend[Transpose[Transpose /@ X[[2]]], X[[1]]];
   X = Transpose[
     {Join @@ 
       Map[(Join @@ Outer @@ Prepend[#, List]) &, 
        Transpose[Take[X, 2]]],
      Map[StripChar[#, " "] &, Join @@ X[[3]]]}];
   X = Select[X, (#[[2]] != "") &];
   X];



PreComputeExifData[fname_] := Module[{X},
   X = ExifData[fname];
   If[IntegerQ[X], Return[X]];
   X = {X, StringJoin[fname, "_ExifData.txt"]};
   If[TrueQ[Check[Put @@ X, -1] === -1], Return[100]];
   X[[2]]];



ReadQRCode[X_] := Module[{f, Y},
   Y = Join @@ Round[255*ImageData[X]];
   f = StringJoin[MyTempDir, "outputstream.dat"];
   Off[DeleteFile::fdnfnd];
   DeleteFile[f];
   On[DeleteFile::fdnfnd];
   BinaryWrite[f, Y];
   Close[f];
   Y = Get[f];
   DeleteFile[f];
   Y];



WriteQRCode[X_] := Module[{f, Y},
   f = StringJoin[MyTempDir, "outputstream.dat"];
   Off[DeleteFile::fdnfnd];
   DeleteFile[f];
   On[DeleteFile::fdnfnd];
   Put[X, f];
   Y = BinaryReadList[f];
   DeleteFile[f];
   Y = Join[Y,
     ConstantArray[32,
      Ceiling[Sqrt[Length[Y]]]^2 - Length[Y]]];
   Y = Partition[Y, Sqrt[Length[Y]]];
   If[Union[Length /@ Y] === {Length[Y]},
    Image[Y, "Byte"],
    1]];



MainFileName = StringReplace[
    FSplit[#][[2]],
    { "_CI" ~~ EndOfString -> "",
     "__xy" ~~ EndOfString -> ""}]&;



FromCloneFileName[f_] := Module[{d, i, k, m, n, s, t},
   
   i = StringPosition[s=f, "_[K"][[1]];
   m = StringTake[s, i[[1]]-1];
   s = StringDrop[s, i[[2]]];
   
   i = StringPosition[s, ",T"][[1]];
   k = ToExpression[StringTake[s, i[[1]]-1]];
   s = StringDrop[s, i[[2]]];
   
   i = StringPosition[s, ",N"][[1]];
   t = StringTake[s, i[[1]]-1];
   s = StringDrop[s, i[[2]]];
   
   i = StringPosition[s, "]"][[1]];
   n = ToExpression[StringTake[s, i[[1]]-1]];
   s = StringDrop[s, i[[2]]];
   
   d = If[StringLength[s]>0, StripChar[s, {" ", "_"}], Null];
   
   {m, k, t, n, d}];



ToCloneFileName[m_, k_, t_, n_, d_] := Module[{s},
   s = StringJoin[m,
     "_[K", StringDrop[ToString[100000+k], 1],
     ",T", If[IntegerQ[t], StringDrop[ToString[1000+t], 1], t],
     ",N", StringDrop[ToString[100+n], 1],
     "]"];
   If[StringQ[d],
    s = StringJoin[s, "__", StripChar[d, {" ", "_"}]]];
   s];
