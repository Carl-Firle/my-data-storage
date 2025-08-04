

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
    ApplyMask,
    AutoCrop,
    ColorMask,
    CreateMask,
    ForegroundMask,
    ForegroundRange,
    MaskAnd,
    MaskOr,
    NonConstantCols,
    NonConstantRows,
    PaintStandardPalette,
    PathMask,
    SaveMask,
    ColorPalette,
    ToBlack];
On[General::"spell"];



PaintStandardPalette = {{0, 0, 0}, {0, 0, 64}, {0, 0, 128}, {0, 0, 
    160}, {0, 0, 255}, {0, 64, 0}, {0, 64, 64}, {0, 64, 128}, {0, 128,
     0}, {0, 128, 64}, {0, 128, 128}, {0, 128, 192}, {0, 128, 
    255}, {0, 162, 232}, {0, 255, 0}, {0, 255, 64}, {0, 255, 128}, {0,
     255, 255}, {34, 177, 76}, {63, 72, 204}, {64, 0, 0}, {64, 0, 
    64}, {64, 0, 128}, {64, 128, 128}, {112, 146, 190}, {127, 127, 
    127}, {128, 0, 0}, {128, 0, 64}, {128, 0, 128}, {128, 0, 
    255}, {128, 64, 0}, {128, 64, 64}, {128, 128, 0}, {128, 128, 
    64}, {128, 128, 128}, {128, 128, 192}, {128, 128, 255}, {128, 255,
     128}, {128, 255, 255}, {136, 0, 21}, {153, 217, 234}, {163, 73, 
    164}, {181, 230, 29}, {185, 122, 87}, {192, 192, 192}, {195, 195, 
    195}, {200, 191, 231}, {237, 28, 36}, {239, 228, 176}, {255, 0, 
    0}, {255, 0, 128}, {255, 0, 255}, {255, 127, 39}, {255, 128, 
    0}, {255, 128, 64}, {255, 128, 128}, {255, 128, 192}, {255, 128, 
    255}, {255, 174, 201}, {255, 201, 14}, {255, 242, 0}, {255, 255, 
    0}, {255, 255, 128}, {255, 255, 255}};



ApplyMask[Img_, Msk_] := Module[{d},
   d = ImageDimensions[Img];
   {ImageMultiply[
      ImageTake@@Prepend[Msk[[1]], Img],
      ImageTake@@Prepend@@Take[Msk, 2]]
   (* ImageTake@@Prepend[
         Msk[[1]],
         ImageMultiply[Img, Msk[[2]]]] *),
    {Msk[[1, 2, 1]] - 1, d[[2]] - Msk[[1, 1, 2]]},
    d,
    Msk[[3]]}];



AutoCrop[bild_] := Module[{A},
   A = ForegroundRange[ImageData[bild]];
   If[Not[And @@ (OrderedQ /@ A)], Return[0]];
   ImageTake @@ Prepend[A, bild]];



ConstantColIndices[imgdat_] := ConstantRowIndices[Transpose[imgdat]];



ConstantRowIndices[imgdat_] := Module[{Z},
   Z = Equal @@@ imgdat;
   Z = Split[Z];
   Z = Map[{#[[1]], Length[#]} &, Z];
   Z = Transpose[Z];
   Z = Append[Z, FoldList[Plus, 0, Z[[2]]]];
   Z[[3]] = Transpose[{
      Drop[Z[[3]], -1] + 1,
      Drop[Z[[3]], 1]}];
   Z = Transpose[Z[[{1, 3}]]];
   Last /@ Select[Z, First]];



NonConstantRows[imgdat_] := Module[{Z},
   Z = Equal @@@ imgdat;
   Z = Split[Z];
   Z = Map[{#[[1]], Length[#]} &, Z];
   Z = Transpose[Z];
   Z = Append[Z, FoldList[Plus, 0, Z[[2]]]];
   Z[[1]] = Not /@ Z[[1]];
   Z[[3]] = Transpose[{
      Drop[Z[[3]], -1] + 1,
      Drop[Z[[3]],  1]}];
   Z = Transpose[Z[[{1, 3}]]];
   Z = Last /@ Select[Z, First];
   Map[Take[imgdat, #] &, Z]];



NonConstantCols[imgdat_] := Transpose/@NonConstantRows[Transpose[imgdat]];



ColorMask[bild_, color_, coldist_, neg_] := Module[{M},
   M = UnitStep[-ImageData[
       ColorSeparate[ColorReplace[bild, color, coldist]][[4]]]];
   If[TrueQ[neg], M = 1 - M];
   {ForegroundRange[M], Image[M, "Bit"], {color, coldist}}];



CreateMask[G_, name_, rectangular_, neg_] := Module[{A, M, x},
   M = Join @@ 
     Map[Position[G, #] &, {Circle, Disk, Line, Polygon, Rectangle}];
   M = Map[Drop[#, -1] &, M];
   A = Map[ReplacePart[#, 0, -1] &, M];
   A = Map[
     If[(Part @@ Prepend[#, G]) === GeometricTransformation, 
       ReplacePart[Part @@ Prepend[Drop[#, -1], G], x, 1], x] &, A];
   M = Map[(Part @@ Prepend[#, G]) &, M];
   M = Map[
     Switch[Head[#], Circle, ReplacePart[#, Disk, 0], Line, 
       Polygon[Drop[#[[1]], -1]], _, #] &, M];
   M = Map[(#[[1]] /. (x -> #[[2]])) &, Transpose[{A, M}]];
   M = ColorConvert[
     Rasterize[
      Style[
       Graphics[{White, M},
        AspectRatio -> Automatic,
        Background -> Black,
        ImageSize -> nx,
        PlotRange -> {{0, nx}, {0, ny}},
        PlotRangePadding -> None],
       Antialiasing -> False]],
     "Grayscale"];
   If[TrueQ[ImageDimensions[M] === {nx, ny}],
    M = Round[ImageData[M]];
    A = ForegroundRange[M];
    If[TrueQ[rectangular],
     M = 1 + Subtract @@@ (Reverse /@ A);             (*    umbeschriebenes Rechteck ausgeben    *)
     M[[2]] = Join[
       ConstantArray[0,          A[[2, 1]] - 1],
       ConstantArray[1,          M[[2]]             ],
       ConstantArray[0, nx - A[[2, 2]]       ]];
     M = Prepend[M, ConstantArray[0, nx]];
     M = Join[
       ConstantArray[M[[1]],          A[[1, 1]] - 1],
       ConstantArray[M[[3]],          M[[2]]             ],
       ConstantArray[M[[1]], ny - A[[1, 2]]       ]]];
    If[TrueQ[neg],
     M = 1 - M;                                       (*    Maske invertieren    *)
     A = ForegroundRange[M]];
    {A, Image[M, "Bit"], name}]];



ForegroundMask[bild_, neg_] := Module[{A, M},
   A = Min[ImageChannels[bild], 3];
   M = ImageData[bild];
   If[A > 1, M = Map[Max[Take[#, A]] &, M, {2}]];
   M = UnitStep[-M];
   If[Not[TrueQ[neg]], M = 1 - M];
   {ForegroundRange[M], Image[M, "Bit"], "foreground"}];



ForegroundRange[ImgDat_] := Module[{ax, ay, by, i, j, M, s},
   If[Not[ListQ[ImgDat]], Return[0]];
   i = 1;
   j = Length[M = ImgDat];
   s = Depth[M[[1, 1]]];
   If[Not[MemberQ[{1, 2}, s]], Return[1]];
   Switch[s,
    1, While[(i <= j) && (Complement[Union[    M[[i]]], {0, 0.}] === {}), i++],
    2, While[(i <= j) && (Complement[Union @@ M[[i]]  , {0, 0.}] === {}), i++],
    _, Return[2]];
   If[i > j, Return[{{j, 1}, {Length[M[[1]]], 1}}]];           (*    keine Vordergrundpixel    *)
   ay = i;
   i = j;
   Switch[s,
    1, While[(i > ay) && (Complement[Union[    M[[i]]], {0, 0.}] === {}), i--],
    2, While[(i > ay) && (Complement[Union @@ M[[i]]  , {0, 0.}] === {}), i--],
    _, Return[3]];
   by = i;
   i = 1;
   j = Length[M = Transpose[Take[M, {ay, by}]]];
   Switch[s,
    1, While[(i <= j) && (Complement[Union[    M[[i]]], {0, 0.}] === {}), i++],
    2, While[(i <= j) && (Complement[Union @@ M[[i]]  , {0, 0.}] === {}), i++],
    _, Return[4]];
   ax = i;
   i = j;
   Switch[s,
    1, While[(i > ax) && (Complement[Union[    M[[i]]], {0, 0.}] === {}), i--],
    2, While[(i > ax) && (Complement[Union @@ M[[i]]  , {0, 0.}] === {}), i--],
    _, Return[5]];
   {{ay, by}, {ax, i}}];



MaskAnd := Module[{M},
    M = Transpose[{##}];
    M[[1]] = Transpose[Transpose /@ Transpose[M[[1]]]];
    M[[1]] = Transpose[{Max /@ M[[1, 1]], Min /@ M[[1, 2]]}];
    M[[2]] = Image[Times @@ (ImageData /@ M[[2]]), "Bit"];
    M[[3]] = 
     StringJoin["(", ConcatStringList[Union[M[[3]]], "&"], ")"];
    M] &;



MaskOr := Module[{M},
    M = Transpose[{##}];
    M[[1]] = Transpose[Transpose /@ Transpose[M[[1]]]];
    M[[1]] = Transpose[{Min /@ M[[1, 1]], Max /@ M[[1, 2]]}];
    M[[2]] = 
     Image[UnitStep[(Plus @@ (ImageData /@ M[[2]])) - 0.5], "Bit"];
    M[[3]] = 
     StringJoin["(", ConcatStringList[Union[M[[3]]], "|"], ")"];
    M] &;



LoadMask[name_] := Module[{G, M},
   M = Take[FSplit[name], 2];
   If[M[[2]] == "", Return[1]];
   G = M[[1]];
   M = StringJoin @@ Append[M, ".dat"];
   M = Check[Get[M], 0];
   If[Not[ListQ[M]]                        , Return[2]];
   If[Length[M] != 4                           , Return[3]];
   If[Not[M[[1]] === {nx, ny}], Return[4]];
   M = Drop[M, 1];
   G = Import[StringJoin[G, M[[2]]]];
   If[Not[ImageQ[G]], Return[5]];
   ReplacePart[M, Binarize[G], 2]];



PathMask[Lines_, thickn_, ImgDim_] := Module[{pr, t, X},
   pr = {{0, 0}, ImgDim};
   t = thickn*ImgDim[[1]]/2;
   X = Position[Lines, Line];
   X = Map[ReplacePart[#, 1, -1] &, X];
   X = Map[(Part @@ Prepend[#, Lines]) &, X];
   X = Map[Transpose[{Drop[#, -1], Drop[#, 1]}] &, X];
   X = Map[Transpose[{#, Normalize /@ Subtract @@@ #}] &, X];
   X = Map[ReplacePart[#, #[[ 1, 1,  1]] - t*#[[ 1, 2]], { 1, 1,  1}]&, X];
   X = Map[ReplacePart[#, #[[-1, 1, -1]] + t*#[[-1, 2]], {-1, 1, -1}]&, X];
   X = Transpose /@ Map[First, X, {2}];
   X = Map[Line[Append[#[[1]], #[[2, -1]]]] &, X];
   X = Graphics[
     {{Black, Rectangle @@ pr},
      {White, Thickness[thickn], X}},
     PlotRange -> Transpose[pr]];
   X = Image[X, ImageSize -> ImgDim];
   If[ImageDimensions[X] === ImgDim,
    X = Binarize[X, 0.00000001];
    If[BinaryImageQ[X], X,
     2],
    1]];



SaveMask[M_, path_] := Module[{G, name},
   name = StringJoin[
     If[StringTake[path, -1] == "\\", path, StringJoin[path, "\\"]],
     "mask\\", M[[3]], "."];
   MakeDir[DirectoryName[name]];
   Put[
    Prepend[
     ReplacePart[M,
      BareName[G = Export[StringJoin[name, "GIF"], M[[2]]]],
      2],
     {nx, ny}],
    name = StringJoin[name, "dat"]];
   If[Binarize[Import[G]] === M[[2]], name, $Failed]];



ColorPalette[img_] := Module[{R, s, v, X},
   s = ImageDimensions[img][[1]];
   R = Join @@ ImageData[img];
   v = Union[R];
   R = Transpose[R];
   R = Map[
     Partition[
       DiscreteDelta /@ Map[(#.#) &, Transpose[R - #]],
       s] &,
     v];
   X = Image[Total[R*Range[Length[R]]]];
   R = Map[Image[#, "Bit"] &, R];
   {Transpose[{v, R}], X}];



ToBlack[palette_, cols_] := Module[{A, B, nc, R, V},
   {V, R} = Transpose[palette[[1]]];
   nc = If[cols === Null, {}, If[ListQ[cols], cols, {cols}]];
   nc = Append[nc, {0., 0., 0.}];
   nc = Flatten[Map[
      If[IntegerQ[#],
        If[1 <= # <= Length[V], {{#}}, {}],
        Position[V,
         If[ListQ[#], #,
          List @@ ColorConvert[#, "RGB"]]]] &, nc]];
   nc = Complement[Range[Length[V]], nc];
   R = R[[nc]];
   V = V[[nc]];
   A = ImageData /@ R;
   B = UnitStep[-Total[A]];
   If[Max[B] == 1,
    A = Prepend[A, B];
    R = Prepend[R, Image[B, "Bit"]];
    V = Prepend[V, {0., 0., 0.}]];
   {Transpose[{V, R}],
    Image[Total[Range[Length[A]]*A]]}];



AlignBGCol = White;



LeftAlign[Imgs_] := Module[{h},
   h = First /@ ImageDimensions /@ Imgs;
   h = Max[h] - h;
   Map[
    ImagePad[#[[1]], {{0, #[[2]]}, {0, 0}}, AlignBGCol] &,
    Transpose[{Imgs, h}]]];



RightAlign[Imgs_] := Module[{h},
   h = First /@ ImageDimensions /@ Imgs;
   h = Max[h] - h;
   Map[
    ImagePad[#[[1]], {{#[[2]], 0}, {0, 0}}, AlignBGCol] &,
    Transpose[{Imgs, h}]]];



BottomAlign[Imgs_] := Module[{h},
   h = Last /@ ImageDimensions /@ Imgs;
   h = Max[h] - h;
   Map[
    ImagePad[#[[1]], {{0, 0}, {0, #[[2]]}}, AlignBGCol] &,
    Transpose[{Imgs, h}]]];



TopAlign[Imgs_] := Module[{h},
   h = Last /@ ImageDimensions /@ Imgs;
   h = Max[h] - h;
   Map[
    ImagePad[#[[1]], {{0, 0}, {#[[2]], 0}}, AlignBGCol] &,
    Transpose[{Imgs, h}]]];



CenterAlignHorizontal[Imgs_] := Module[{h},
   h = First /@ ImageDimensions /@ Imgs;
   h = Max[h] - h;
   h = Map[{#, Quotient[#, 2]} &, h];
   h = Map[ReplacePart[#, Subtract @@ #, 1] &, h];
   Map[
    ImagePad[#[[1]], {#[[2]], {0, 0}}, AlignBGCol] &,
    Transpose[{Imgs, h}]]];



CenterAlignVertical[Imgs_] := Module[{h},
   h = Last /@ ImageDimensions /@ Imgs;
   h = Max[h] - h;
   h = Map[{#, Quotient[#, 2]} &, h];
   h = Map[ReplacePart[#, Subtract @@ #, 1] &, h];
   Map[
    ImagePad[#[[1]], {{0, 0}, #[[2]]}, AlignBGCol] &,
    Transpose[{Imgs, h}]]];
