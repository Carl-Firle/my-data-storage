


MyDateConv       = If[Head[#]===DateObject, DateList[#], Null]&;
$DisplayFunction = Print;



<< ErrorBarPlots`;
<< HypothesisTesting`;



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
    PROJECT,
    MyHomeBat,
    MyTempDir,
    EpiWaferList,
    ExcelDataPath,
    MathematicaDataPath,
    SMWaferMapPath,
    EpiWaferMapPath,
    BIMapPath,
    ShowSMWaferMap,
    SlowConnection,
    DisplayTrendGraph,
    AutomaticLighting,
    NeutralLighting,
    ContHistoClasses,
    SIEMENSColor,
    WaferColor,
    SMXSize,
    SMYSize,
    SMDiv,
    MyColFunc,
    MyTS,
    UCL,
    TheseTempFiles,
    ExistingPositions,
    DefaultColumns,
    UnitConversionTable,
    ExpressionVariables,
    NIf,
    PositiveAngle,
    Integerize,
    UnN,
    GraphicsBox2Graphics,
    GrayLevelAnd,
    GrayLevelNot,
    GrayLevelOr,
    EquallySpaced,
    CalcCircle2D,
    TriangleCoordinates,
    Later,
    ATF,
    SafeToExpression,
    SequenceQ,
    StripChar,
    numcnv,
    ToInteger,
    ToNumber,
    BareName,
    FSplit,
    NoBlanks,
    DupRem,
    Entries,
    SelectRows,
    NewColumn,
    ShowTable,
    ConcatStringList,
    SplitListString,
    FileCheckString,
    RecyclerActive,
    RecyclerRoot,
    SecureFileCopy,
    SecureFileCopyCreateDir,
    SecureFileMove,
    SecureFileMoveCreateDir,
    MyDeleteFile,
    UndoMyDeleteFile,
    FastGet,
    FastPut,
    FastImport,
    FastExport,
    MakeDir,
    MakeNewDir,
    MDExport,
    DelEmptyDirs,
    Attrib,
    UpDir,
    CollectFiles,
    MoveFiles,
    MyFileCopy,
    TreeCopy,
    RemoveTempFiles,
    RealForm,
    ExcelForm,
    DateForm,
    SafeDiv,
    NextDigit,
    GeneralDigits,
    MyMerge,
    RemoveDuplicates,
    MyPartition,
    AllPositions,
    StrgPart,
    MyStringPartition,
    SortByString,
    FromWallClock,
    ToWallClock,
    GoogleDate,
    MathVersion,
    BlackBodyIntensity, MyLambda,
    ContHisto,
    SavGol,
    SavitzkyGolayFilter,
    StringCRC,
    UnitConversion,
    TraceableLD,
    TranslateEpiWafer,
    RenameCHICHA,
    ZIPContents,
    LoadSP1,
    ReadNMF,
    ReadBHNMF,
    CountColumn,
    ExtractColumn,
    ExtractTDrift,
    MergeData,
    SaveProberData,
    SMWaferMap,
    CorrStat,
    CorrelationPlot,
    PairCorrelations,
    AccuracyReport,
    OneTempSMWaferMaps,
    StandardSMWaferMaps85,
    StandardSMWaferMaps95,
    GoodParts,
    SelectPartsNMF,
    CRCEncodeNMF,
    MyPowerRange,
    CleanUpKL,
    CropKL,
    PolSwitchKL,
    ExtractKL,
    GatherData,
    LoadAllKL,
    MergeKL,
    PlotAllKL,
    TakeKL,
    Consider,
    Discard,
    SelectBad,
    YStat,
    Trend,
    TrendDataPlot,
    ClusterPlot,
    Outliers2D,
    ShowOutliers2D,
    findout,
    MergeMB,
    LoadPMF,
    ImgDatToPixPos,
    PixPosToImgDat];
On[General::"spell"];


PROJECT             = "\\\\Blnw803a\\PROJECTS\\W_Components\\W04_Produktentwicklung\\Project_10G_TOSA\\00_AtWork\\";
MyHomeBat           = "C:\\UserData\\HOME.BAT";
MyTempDir           = "C:\\Users\\Carl\\Documents\\Wolfram Mathematica\\temp_Mathematica\\";
Utilities           = "E:\\Stier\\Utilities\\";

RecyclerActive          = True;
RecyclerRoot            = "$_MathRecycler\\";
SecureFileCopyCreateDir = False;
SecureFileMoveCreateDir = False;

EpiWaferList        = StringJoin[PROJECT, "Wafer-Maps\\AlleChargen"];
ExcelDataPath       = StringJoin[PROJECT, "Proberdaten\\Excel\\"];
MathematicaDataPath = StringJoin[PROJECT, "Proberdaten\\Mathematica\\"];
SMWaferMapPath      = StringJoin[PROJECT, "Wafer-Maps\\Submount-Wafer\\"];
EpiWaferMapPath     = StringJoin[PROJECT, "Wafer-Maps\\Epi-Wafer\\"];
BIMapPath           = StringJoin[PROJECT, "Burn-In\\"];
ShowSMWaferMap      = True;
SlowConnection      = True;
DisplayTrendGraph   = True;

AutomaticLighting = {
   {"Ambient", RGBColor[{0.312, 0.188, 0.4}]},
   {"Directional", RGBColor[{0.8, 0., 0.}], ImageScaled[{2, 0, 2}]},
   {"Directional", RGBColor[{0., 0.8, 0.}], ImageScaled[{2, 2, 2}]},
   {"Directional", RGBColor[{0., 0., 0.8}], ImageScaled[{0, 2, 2}]}};

NeutralLighting = {
   {"Ambient", RGBColor[{.35, .35, .35}]},
   {"Directional", RGBColor[{.37, .37, .37}], ImageScaled[{2, 0, 2}]},
   {"Directional", RGBColor[{.37, .37, .37}], ImageScaled[{2, 2, 2}]},
   {"Directional", RGBColor[{.37, .37, .37}], ImageScaled[{0, 2, 2}]}};


ContHistoClasses = 1024;


SIEMENSColor = ColorConvert[RGBColor@@N[{0, 153, 153}/255], "HSB"];
WaferColor   = GrayLevel[0.95];
(*
SMXSize    = 62;
SMYSize    = 82;
SMDiv      = 100;
*)
SMXSize    =   74;
SMYSize    =   92;
SMDiv      = 1000;


ExistingPositions := Module[{h, i, j},
        h = Join@@Table[{i, j}, {i, SMXSize}, {j, SMYSize}];
        Transpose[{h, Table[i, {i, Length[h]}]}]];


MyColFunc = Hue[0.03+0.75*(1-#)]&;


MyTS = {FontColor  -> Black,
        FontFamily -> "Arial",
        FontSlant  -> "Plain",
        FontWeight -> "Plain",
        FontSize   -> 12};
TheseTempFiles = {};
UCL            = False;


DefaultColumns = {"SUBMOUNT","CHICHALD","CHIPOSLD","RINGNRLD","CHICHAMD","RINGNRMD",
     "POPT25","ITH25","E_F25","IF25","UF125","UF225","RS25","SSAT25",
     "LAMBDA25","LOSS1_25","SMSR1_25","SML1_25","SMR1_25","KONT25",
     "IMON25", "E_MON25", "ID_MON25",
     "POPT85","ITH85","E_F85","IF85","UF185","UF285","RS85","SSAT85",
     "LAMBDA85","LOSS1_85","SMSR1_85","SML1_85","SMR1_85","KONT85",
     "IMON85", "E_MON85", "ID_MON85",
     "POPT95","ITH95","E_F95","IF95","UF195","UF295","RS95","SSAT95",
     "LAMBDA95","LOSS1_95","SMSR1_95","SML1_95","SMR1_95","KONT95",
     "IMON95", "E_MON95", "ID_MON95"};


Clear[f,x];
UnitConversionTable = {"G", "M", "k", "", "m", "u", "n", "p"};
UnitConversionTable = {Drop[UnitConversionTable,-1],
                       Drop[UnitConversionTable, 1]};
UnitConversionTable = Transpose[
      Append[UnitConversionTable,
        Map[1000&,UnitConversionTable[[1]]]]];
f[x_] := Map[{StringJoin[#[[1]],x],
              StringJoin[#[[2]],x],
                         #[[3]]   }&,
             UnitConversionTable];
UnitConversionTable = Join@@Append[Map[f,{"A", "Hz", "m", "Ohm", "s", "V", "W"}],
        {{"W/A", "mW/A", 1000},{"V/A", "Ohm", 1},{"-", "%", 100}}];
Clear[f,x];



ExpressionVariables[X_] := Module[{},
   If[NumericQ[X], Return[{}]];
   If[Head[X]===Symbol, (* Print[X]; *) Return[X]];
   Complement[
      Flatten[ExpressionVariables/@List@@X],
      {}]];



NIf = Piecewise[{{#2, #1}, {#3, Not[#1]}}]&;



PositiveAngle := (2*Pi*SawtoothWave[Rationalize[#, 0]/(2*Pi)])&;



Integerize[expr_] := Module[{h, x, Y},
   h = Head[expr];
   Y = Switch[h,
     Function, Last[expr],
     _, expr];
   Y = Y /. (x_ :> Round[x] /; FractionalPart[x] == 0);
   Switch[h,
    Function, ReplacePart[expr, Y, -1],
    _, Y]];



UnN[expr_] := Module[{h, x, Y},
   h = Head[expr];
   Y = Switch[h,
     Function, Last[expr],
     _, expr];
   Y = Y /. (x_ :> Rationalize[x, 0] /; NumericQ[x]);
   Switch[h,
    Function, ReplacePart[expr, Y, -1],
    _, Y]];



GraphicsBox2Graphics[X_] := Module[{f},
   f = If[StringQ[#],
        If[StringTake[#, 1] === StringTake[#, -1] === "\"",
         StringTake[#, {2, -2}],
         #], #] &[#1] &;
   Graphics[
    X[[1]],
    X[[2]] /. {
      Typeset`Hold -> Identity,
           FormBox -> f,
          StyleBox -> f}]];



GrayLevelOr  = Apply[Max, Transpose[{##}, {3, 1, 2}], {2}]&;
GrayLevelAnd = Apply[Min, Transpose[{##}, {3, 1, 2}], {2}]&;
(*
GrayLevelOr  = Transpose[Apply[Max, Transpose[{##}, {3, 2, 1}], {2}]]&;
GrayLevelAnd = Transpose[Apply[Min, Transpose[{##}, {3, 2, 1}], {2}]]&;
*)
GrayLevelNot = (1-#)&;



EquallySpaced[x1_, x2_, n_] := Module[{X},
   X = Sort[{x1, x2}];
   X[[2]] = -Subtract @@ X;
   X = Append[X, Max[1, If[IntegerQ[n], n - 1, Round[X[[2]]/n]]]];
   X[[3]] = Range[0, X[[3]]]/X[[3]];
   X[[1]] + X[[2]]*X[[3]]];



CalcCircle2D[Pts_] := Module[{Mx, My, r, S},        (*    Kreis aus drei 2D-Punkten    *)
   If[Length[Pts] != 3, Return[1]];
   If[Length /@ Pts != {2, 2, 2}, Return[2]];
   S = Solve[
     Map[
      UnN[#.# == r] &,
      Transpose[Transpose[Pts] - {Mx, My}]],
     {Mx, My, r}];
   If[Length[S] != 1, Return[3]];
   {Mx, My, r} = {Mx, My, r} /. S[[1]];
   r = Sqrt[r];
   {{Mx, My}, r}];



TriangleCoordinates = Compile[        (*    Goering, Roos, Tobiska, FEM, Deutsch-TB Bd.   68, S. 43    *)
  {x1, y1,                            (*    Ecke 1      *)
   x2, y2,                            (*    Ecke 2      *)
   x3, y3,                            (*    Ecke 3      *)
   x , y },                           (*    Aufpunkt    *)
  Block[{d = x3 (y1 - y2) + x1 (y2 - y3) + x2 (-y1 + y3)},
     If[d == 0, {0, 0, 0},            (*    Dreieck ist entartet    *)
        {
        x3 (y - y2) + x (y2 - y3) + x2 (-y + y3),
        x3 (-y + y1) + x1 (y - y3) + x (-y1 + y3),
        x2 (y - y1) + x (y1 - y2) + x1 (-y + y2)
        }/d]
  ]];



UpDir[s_] := DirectoryName[StringDrop[If[StringTake[s, -1]=="\\", s, DirectoryName[s]], -1]];



Later[fst_, scd_] := If[#=={}, False, #[[1]]>0]&[Select[scd-fst, (#!=0)&]];



ATF[f_] := Module[{},
      TheseTempFiles = Append[TheseTempFiles,f];
      f];



SafeToExpression[X_] := Check[ToExpression[X],X];



SequenceQ = (Length[#]===1+Max[#]-Min[#])&;



StripChar[S_, c_] := Module[{d, Y},
   d = If[ListQ[c], c, {c}];
   If[StringQ[S],
      Y = S;
      While[If[Y=="", False, MemberQ[d, StringTake[Y,  1]]], Y = StringDrop[Y,  1]];
      While[If[Y=="", False, MemberQ[d, StringTake[Y, -1]]], Y = StringDrop[Y, -1]];
      Y,
      S]];



numcnv[s_] := Module[{z},
      If[Not[StringQ[s]],             Return[s]   ];
      If[MemberQ[{"-"}, s],           Return[s]   ];
      If[MemberQ[{"NaN", "#N/A"}, s], Return[Null]];
      z = s;
      If[(StringPosition[z, "."]!={})&&(StringPosition[z, ","]!={}),
         z = StringReplace[z,
            {"." -> "",
             "," -> "."}]];
      z = StringReplace[z,
            {" " -> "" ,
             "," -> ".",
             "e" -> "E"}];
      z = StringReplace[z,
            {".E" -> ".0E"}];
      z = StringReplace[z,
            {"E-" -> "*10^-",
             "E+" -> "*10^" ,
             "E"  -> "*10^" }];
(*             
      z = StringReplace[s,
            {" "  -> ""     ,
             "e-" -> "*10^-",
             "E-" -> "*10^-",
             "e+" -> "*10^" ,
             "E+" -> "*10^" ,
             "E"  -> "*10^" ,
             ","  -> "."    }];
*)
      If[Not[Complement[
               Characters[z],
               {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "+", "-", "*", "^"}]==={}],
         Return[s]];
      If[Length[StringPosition[z, "."]]>1, Return[s]];
      If[Check[z=ToExpression[z], True], Return[s]];
      If[NumberQ[z], z, s]];



ToInteger[s_] := Module[{x},
   If[Not[StringQ[s]]                                                                                 , Return[s]];
   x = StripChar[s, " "];
   If[x==""                                                                                           , Return[s]];
   If[Not[MemberQ[{"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "-"}, StringTake[x, 1]]]    , Return[s]];
   If[Not[Complement[Drop[Characters[x], 1], {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}]==={}], Return[s]];
   x = Check[ToExpression[x], Null];
   If[IntegerQ[x], x                                                                                  ,        s ]];



ToNumber[X_] := If[MemberQ[{Integer,Real,Complex},Head[#]],#,X]&[SafeToExpression[X]];



BareName[f_] := If[#=={}, f, StringDrop[f, #[[-1, -1]]]]&[StringPosition[f, "\\"]];



FSplit[fname_] := Module[{d, e, n},
      If[Not[StringQ[fname]], Return[]];
      d = StringPosition[fname, "\\"];
      d = If[d=={}, "", StringTake[fname, d[[-1, -1]]]];
      n = StringDrop[fname, StringLength[d]];
      e = StringPosition[n, "."];
      If[e=={}, e = "",
         e = e[[-1, 1]]-1;
         {e, n} = {StringDrop[n, e], StringTake[n, e]}];
      {d, n, e}];



NoBlanks = StringJoin[DirectoryName[#], StringReplace[BareName[#], " " -> "_"]]&;



FileCheckString = IntegerString[FileHash[#, "SHA512"], 16, 128]&;



MyDeleteFile[fname_] := Module[{c, t},
   If[Not[TrueQ[RecyclerActive]], Return[DeleteFile[fname]]];
   If[Not[TrueQ[StringTake[fname, {2, 3}]===":\\"]], Return[1]];
   t = StringJoin[
     StringTake[fname, 3],
     If[StringTake[RecyclerRoot, -1]=="\\",
                   RecyclerRoot,
        StringJoin[RecyclerRoot, "\\"]],
     StringDrop[fname, 3]];
   MakeDir[DirectoryName[t]];
   c = RenameFile[fname, t];
   If[TrueQ[c===t], Null, c]];



UndoMyDeleteFile[RecyclerLongPath_] := Module[{F, P, R, T},
   P = If[StringTake[RecyclerLongPath, -1] == "\\",
                     RecyclerLongPath,
          StringJoin[RecyclerLongPath, "\\"]];
   F = FileNames[{"*"}, {P}, Infinity];
   F = Select[F, (FileType[#] === File) &];
   R = {4, StringLength[P]};
   R = Map[StringDrop[#, R] &, F];
   MakeDir /@ Union[DirectoryName /@ R];
   T = RenameFile @@@ Transpose[{F, R}];
   T = First /@ Select[
      Map[
       {#[[1]], Not[TrueQ[SameQ @@ #]]} &,
       Transpose[{R, T}]],
      Last];
   If[T != {},
      Print["\nUnable to restore the following ",
            Length[T],
            " files:\n\n",
            T, "\n"]];
   Off[DeleteDirectory::dirne];
   DeleteDirectory /@ Reverse[Union[DirectoryName /@ F]];
   On[DeleteDirectory::dirne];
   DelEmptyDirs[P];
   Off[DeleteDirectory::dirne];
   DeleteDirectory[P];
   On[DeleteDirectory::dirne];
   Print["\n    ",
         Length[R] - Length[T],
         " files restored.\n"];
   T];



SecureFileCopy[OverWrite_, From_, To_] := Module[{B, S, TE},
   If[From === To, Return[$Failed]];
   TE = Switch[FileType[To],
     File, True,
     None, False,
     _, 1];
   If[IntegerQ[TE], Return[1]];
   If[TE,
    If[TrueQ[OverWrite],
     B = StringJoin[To, "_AutoBackup"];
     If[Not[RenameFile[To, B] === B], Return[2]],
     Return[0]]];
   S = FileCheckString[From];
   If[TrueQ[SecureFileCopyCreateDir], MakeDir[DirectoryName[To]]];
   If[Not[CopyFile[From, To] === To], Return[$Failed]];
   If[Not[FileCheckString[To] === S], Return[$Failed]];
   If[TE,
    If[Not[DeleteFile[B] === Null], Return[3]]];
   To];



SecureFileMove[OverWrite_, From_, To_] := Module[{S, Y},
   S = SecureFileCopyCreateDir;
       SecureFileCopyCreateDir = SecureFileMoveCreateDir;
   Y = SecureFileCopy[OverWrite, From, To];
       SecureFileCopyCreateDir = S;
   If[Not[Y === To], Return[Y]];
   If[DeleteFile[From] === Null, To, 4]];



FastGet[name_] := Module[{f, Y},
      If[Not[SlowConnection]                                                 , Return[Get[name]]];
      If[Check[MemberQ[{"C:", "D:", "E:", "F:"}, ToUpperCase[StringTake[name, 2]]], True], Return[Get[name]]];
      f = StringJoin[MyTempDir, "tmp", ToString[RandomInteger[{1000000, 9999999}]], "_", BareName[name]];
      (*
      Run[StringJoin["copy \"", name, "\" \"", f, "\""]];
      *)
      Y = Get[f=CopyFile[name, f]];
      DeleteFile[f];
      Y];



FastPut[X_, name_] := Module[{f},
      If[Not[SlowConnection], 
         Put[X, name]; 
         Return[]];
      If[Check[MemberQ[{"C:", "D:", "E:", "F:"}, ToUpperCase[StringTake[name, 2]]], True], 
         Put[X, name]; 
         Return[]];
      f = StringJoin[MyTempDir, "tmp", ToString[RandomInteger[{1000000, 9999999}]], "_", BareName[name]];
      Off[DeleteFile::nffil];
      DeleteFile[{f, name}];
      On[DeleteFile::nffil];
      Put[X, f];
      Return[RenameFile[f, name]];
      Run["del", name];
      Put[X, f];
      Run[StringJoin["copy \"", f, "\" \"", name, "\""]];
      DeleteFile[f];
      ];



FastImport[name_, type_] := Module[{f, Y},
      If[Not[SlowConnection], 
         Return[
           If[Check[Head[type]===String, False],
              Import[name, type],
              Import[name      ]]]];
      If[Check[MemberQ[{"C:", "D:", "E:", "F:"}, ToUpperCase[StringTake[name, 2]]], True], 
         Return[
           If[Check[Head[type]===String, False],
              Import[name, type],
              Import[name      ]]]];
      f = StringJoin[MyTempDir, "tmp", ToString[RandomInteger[{1000000, 9999999}]], "_", BareName[name]];
      f = CopyFile[name, f];
      (*
      Run[StringJoin["copy \"", name, "\" \"", f, "\""]];
      *)
      Y = If[Check[Head[type]===String, False],
             Import[f, type],
             Import[f      ]];
      DeleteFile[f];
      Y];



FastExport[name_, X_, type_] := Module[{f, Y},
      If[Not[SlowConnection],
        Return[
          If[Check[Head[type]===String, False],
            Export[name, X, type],
            Export[name, X      ]]]];
      If[Check[MemberQ[{"C:", "D:", "E:", "F:"}, ToUpperCase[StringTake[name, 2]]], True],
        Return[
          If[Check[Head[type]===String, False],
            Export[name, X, type],
            Export[name, X      ]]]];
      f = StringJoin[MyTempDir, "tmp", ToString[RandomInteger[{1000000, 9999999}]], "_", BareName[name]];
      (*
      Run["del", name];
      *)
      Off[DeleteFile::nffil];
      DeleteFile[name];
      On[DeleteFile::nffil];
      Y = If[Check[Head[type]===String, False],
             Export[f, X, type],
             Export[f, X      ]];
      Return[RenameFile[Y, name]];
      Run[StringJoin["copy \"", f, "\" \"", name, "\""]];
      DeleteFile[f];
      name];



MakeDir[d_] := Module[{p},
      p = If[StringTake[d, -1] == "\\", StringDrop[d, -1], d];
      If[FileType[p]===Directory, Return[]];
      Off[CreateDirectory::ioarg,CreateDirectory::ioerr];
      If[Not[CreateDirectory[p] === $Failed],
        Print["\n    Creating new directory  ", p, "\n"]];
      On[CreateDirectory::ioarg,CreateDirectory::ioerr];];



MakeNewDir[d_] := MakeDir/@Drop[Reverse[NestWhileList[DirectoryName, d, (StringLength[#]>3)&]], 1];



MDExport := (MakeDir[DirectoryName[#1]]; Export[##])&;



DelEmptyDirs[path_] := Module[{d, f, F },
   F = FileNames[{"*"}, If[ListQ[path], path, {path}], Infinity];
   If[F == {}, Return[{}]];
   F = {FileType /@ F, F};
   If[Not[Complement[F[[1]], {Directory, File}] === {}], Return[]];
   F = Transpose[F];
   d = Select[F, (#[[1]] === Directory) &];
   Print[Length[d], " directories"];
   If[d == {}, Return[{}]];
   f = Complement[F, d];
   Print[Length[f], " files"];
   d = Transpose[d][[2]];
   If[f != {},
      f = Transpose[f][[2]];
      d = Complement[
             Map[StringJoin[#, "\\"] &, d],
             Union@@Map[Take[Reverse[NestWhileList[DirectoryName, #, StringLength[#1] > 0 &]], {2, -2}] &, f]];
      If[d != {},
         f = FileNames[{"*"}, d, Infinity];
         If[f != {},
            If[Not[Union[FileType /@ f] === {Directory}],
               Return[]]]]];
   Print[Length[d], " empty directories"];
   If[d == {}, Return[{}]];
   d = Reverse[Sort[d]];
   Print[Column[d]];
   If[Union[DeleteDirectory /@ d] === {Null}, Print["  deleted."]];
   d];



Attrib[path_, filemask_, paramstring_] := Module[{h},
      h = OpenWrite["C:\\temp\\a.bat"];
      WriteString[h, "@echo off\n"];
      If[StringTake[path, {2}]===":",
         WriteString[h, StringTake[path, 2], "\n"];
         WriteString[h, "cd \"", StringDrop[path, 2], "\"\n"],
         WriteString[h, "cd \"", path, "\"\n"]];
      WriteString[h, "attrib ", paramstring, " ", filemask, " > C:\\temp\\a.out\n"];
      (*
      WriteString[h, "pause\n"];
      *)
      Run[h=Close[h]];
      h = Import["C:\\temp\\a.out", "Lines"];
      DeleteFile/@{"C:\\temp\\a.bat", "C:\\temp\\a.out"};
      h];



CollectFiles[mask_, path_, depth_] := Module[{f, m},
      f = FileNames[{mask}, {path}, depth];
      If[f=={}, Return[f]];
      m = StringReplace[
            MyStringPartition[mask, {"."}][[1]],
            {"*" -> "",
             "_" -> "",
             "-" -> ""}];
      MakeDir[m=StringJoin[MyTempDir, "Collected_", m, "\\"]];
      Map[CopyFile[#, StringJoin[m, BareName[#]]] &, f]];



MoveFiles[H_] := Module[{Y},
      Y = Select[Map[Append[#, CopyFile@@#]&, H], (#[[2]]===#[[3]])&];
      If[Y=={}, Return[{}]];
      DeleteFile[Map[#[[1]]&, Y]];
      Map[#[[3]]&, Y]];



MyFileCopy[from_, to_] := Module[{a},
    MakeNewDir[DirectoryName[to]];
    Check[CopyFile[from, to],
          While[Not[MemberQ[{0, 1}, a = Input[
                StringJoin[
                   "Overwrite\n  ", BareName[to],
                   "\nin\n  ", DirectoryName[to],
                   "\n?\n        no = 0        yes = 1"]]]], Null];
          If[a==1,
             DeleteFile[to];
             CopyFile[from, to],
             $Failed],
          {CopyFile::"filex"}]];



TreeCopy[FileMasks_, SourceDirs_, SubDirLevel_, DestDir_] := Module[{F, s, S, T},
      F = Select[
          FileNames[
            If[ListQ[FileMasks], FileMasks, {FileMasks}],
            S = If[ListQ[SourceDirs], SourceDirs, {SourceDirs}],
            SubDirLevel],
          (FileType[#] === File) &];
      Print["\n    ", RealForm[Length[F], 12, 0], " matching files found"];
      T = If[StringTake[DestDir, -1] == "\\", DestDir, StringJoin[DestDir, "\\"]];
      T = Map[(# -> StringJoin[T, BareName[#]]) &, S];
      T = Map[StringReplace[#, T] &, F];
      S = Map[Drop[StrgPart[#, "\\"], -1] &, StringReplace[T, "\\\\" -> "::::::"]];
      S = Map[StringReplace[#, "::::::" -> "\\\\"] &, S, {2}];
      S = Union@@Map[Drop[FoldList[StringJoin[#1, "\\", #2] &, #[[1]], Drop[#, 1]], 1] &, S];
      MakeDir /@ S;
      S = Transpose[{F, CopyFile @@@ Transpose[{F, T}]}];
      T = Select[S, Not[StringQ[#[[2]]]] &];
      S = Complement[S, T];
      s = Map[FileByteCount, S, {2}];
      s = Append[Transpose[s], Equal @@@ s];
      Print["\n    ",
        RealForm[Count[s[[3]], True], 12, 0], " files   complete,    ",
        RealForm[Plus @@ s[[2]], 12, 0], " Bytes copied\n    ",
        RealForm[Count[s[[3]], False], 12, 0], " files incomplete,    ",
        RealForm[(Plus @@ s[[1]]) - (Plus @@ s[[2]]), 12, 0], 
        " Bytes missing"];
      s = Union[Map[DirectoryName[#[[1]]] &, S]];
      Print["\n    ", RealForm[Length[s], 12, 0], " Source directories:"];
      Print[Column[s]];
      If[T != {}, 
        Print["\n    ", Length[T], " files could not be copied:\n", 
          Column[Sort[Transpose[T][[1]]]]]]];



RemoveTempFiles := Module[{d, f},
      If[TheseTempFiles=={}, Return[]];
      f = Map[{#, DeleteFile[#]}&, Union[TheseTempFiles]];
      d = Select[f, (#[[2]]===Null)&];
      If[d!={}, d = Transpose[d][[1]]];
      TheseTempFiles = Complement[Transpose[f][[1]], d];
      If[d!={},
        Print["\n    The following files were deleted:"];
        Scan[Print["      ", #]&, d]];
      If[TheseTempFiles!={},
        Print["\n    The following files could not be deleted:"];
        Scan[Print["      ", #]&, TheseTempFiles]];
      Print[]];



RealForm[z_, t_, n_] := Module[{i, j, s, y},
      i = If[n > 0, n, 0];
      s = If[z < 0, "-", ""];
      y = ToString[Round[10^i*Abs[z]]];
      y =
        StringJoin[s, StringJoin @@ Table["0", {j, i + 1 - StringLength[y]}],
          y];
      If[i > 0, y = StringInsert[y, ".", -i - 1]];
      StringJoin[StringJoin @@ Table[" ", {i, t - StringLength[y]}], y]];



ExcelForm := StringReplace[RealForm[##], "." -> ","]&;



DateForm[L_] := Module[{s, t},
      s = Prepend[
             Map[StringDrop[#, 1]&, ToString/@(100+Round[Drop[L, 1]])],
             ToString[L[[1]]]];
      t = Min[6, Length[s]];
      StringJoin@@Join@@Transpose[
         {Take[s, t],
          Append[Take[{"-", "-", " ", ":", ":"}, t-1], ""]}]];



SafeDiv[a_, b_] := If[NumberQ[a]&&NumberQ[b],
                      If[b!=0, a/b, Null],
                      Null];



NextDigit[L_, base_] := Module[{i, Y},
      Y = If[ListQ[L], L, If[IntegerQ[L], {L}, {}]];
      If[Y=={}, Return[L]];
      Join[Drop[Y, -1],
           {i=Floor[Y[[-1]]/base],
            Y[[-1]]-base*i}]];



GeneralDigits[z_, basis_] := Module[{a, b},
      b = Times@@basis;
      Fold[(a=b; b/=#2; NextDigit[#1, a])&, z, basis]];



MyMerge[a_, b_, key_, keepkey_] := Module[{c, i, j},
      c = Intersection[
          Transpose[a][[key]],
          Transpose[b][[key]]];
      If[c == {}, Return[{}]];
      i = Map[(#[[key]] -> Drop[#, {key, key}]) &, a];
      j = Map[(#[[key]] -> Drop[#, {key, key}]) &, b];
      If[keepkey,
        Transpose[{c, Transpose[{c /. i, c /. j}]}],
        Transpose[              {c /. i, c /. j}]  ]];



RemoveDuplicates[M_, key_, takefirst_] := Module[{i, k, r},
      k = If[Head[key] === List, key, {key}];
      i = Union[Map[Part @@ Evaluate[Prepend[k, #]] &, M]];
      r = Map[(Part @@ Evaluate[Prepend[k, #]] -> #) &,
              If[takefirst, M, Reverse[M]]];
      i /. r];



MyPartition[k_, L_] := Module[{H, K, s},
      If[L=={}, Return[{}]];

      Return[
        Map[ReplacePart[#, #[[1, 1]], 1]&,
         Transpose/@SplitBy[
           Sort[Map[{#[[k]], Drop[#, {k}]}&, L]],
           First]]];

      H = Transpose[Sort[Map[{#[[k]], Drop[#, {k, k}]} &, L]]];
      K = H[[1]];
      H = H[[2]];
      K = Map[{#, Count[K, #]} &, Union[K]];
      s = 0;
      K = Transpose[Map[ReplacePart[#, s += #[[2]], 2] &, K]];
      K = Insert[K, 1 + Prepend[Drop[K[[2]], -1], 0], 2];
      K = Transpose[{K[[1]], Transpose[Drop[K, 1]]}];
      Map[ReplacePart[#, Take[H, #[[2]]], 2] &, K]];



AllPositions[In_, Of_] := Module[{a, P},
   If[Length[Of] == 0, Return[{}]];
   If[Length[In] == 0, Return[ConstantArray[{}, Length[Of]]]];
   P = Join[
     Transpose[{In,  a =            Range[Length[In]]}],
     Transpose[{Of, (a = a[[-1]]) + Range[Length[Of]]}]];
   P = Join @@@ Transpose[MyPartition[1, P]][[2]];
   P = Map[
     If[Length[#] == 1,
       If[#[[1]] > a,
        {{}, # - a},
        0],
       {Select[#, (# <= a) &],
        Select[#, (# >  a) &] - a}] &,
     P];
   P = Select[P, ListQ];
   P = Select[P, (#[[2]] != {}) &];
   P = Map[(
        a = #[[1]];
        Map[{#, a} &, #[[2]]]) &,
      P];
   P = SortBy[Join @@ P, First];
   P = Transpose[P][[2]];
   Map[
    If[Length[#] == 1,
      #[[1]],
      #] &,
    P]];



StrgPart[s_,tzz_] := Module[{a,y,tz},
      tz = If[ListQ[tzz],tzz,{tzz}];
      y = StringReplace[s,Map[(#->tz[[1]])&,Drop[tz,1]]];
      a = StringPosition[y,tz[[1]]];
      If[a=={},Return[{y}]];
      a = Transpose[Partition[Append[Prepend[Flatten[a],0],1+StringLength[y]],2]];
      a[[1]] += 1;
      a[[2]] -= 1;
      Map[StringTake[y,#]&,Transpose[a]]];



MyStringPartition[s_,tzz_] := Module[{a,y,tz},
      tz = If[ListQ[tzz],tzz,{tzz}];
      y = StringReplace[s,Map[(#->tz[[1]])&,Drop[tz,1]]];
      a = StringJoin[tz[[1]],tz[[1]]];
      While[StringPosition[y,a]!={},y=StringReplace[y,a->tz[[1]]]];
      a = StringPosition[y,tz[[1]]];
      If[a=={},Return[{y}]];

      a = List@@IntervalUnion@@Interval/@a;                 (*    16.11.2015    *)

      a = Transpose[Partition[Append[Prepend[Flatten[a],0],1+StringLength[y]],2]];
      a[[1]] += 1;
      a[[2]] -= 1;
      Map[StringTake[y,#]&,Transpose[a]]];



SortByString[L_, f_] := Module[{i, k},
   k = f /@ L;
   k = ToCharacterCode /@ k;
   i = Max[Length /@ k];
   k = Map[Join[#, ConstantArray[0, i - Length[#]]] &, k];
   k = Transpose[{Round[k], L}];
   k = SortBy[k, First];
   Last /@ k];



FromWallClock[s_]  := DateList[      s + AbsoluteTime[{1970, 1, 1}]];
  ToWallClock[dt_] := AbsoluteTime[dt] - AbsoluteTime[{1970, 1, 1}];



GoogleDate = (2452122+DaysBetween[{2001, 8, 1}, Take[#, 3]])&;



MathVersion[nb_] := Module[{f, s, v},
      f = OpenRead[nb];
      v = {};
      While[v == {},
         If[(v = StringPosition[s = Read[f, String], "CreatedBy"]) != {},
            s = MyStringPartition[StringDrop[s, v[[-1, -1]]], "'"][[2]];
            s = StringReplace[s, {"Mathematica" -> "", " " -> ""}]]];
      Close[f];
      s];



BlackBodyIntensity[Temperature_, WaveLength_] = (
        1.19*^-16*Pi/(MyLambda^5*(Exp[1.438*^-2/(Temperature*MyLambda)]-1))
        )/.MyLambda->(10^-9*WaveLength);



ContHisto[r_] := Module[{k=ContHistoClasses, n, x},
      k = Range[0, k]/k;
      n = Length[x=Sort[Select[Flatten[r], NumberQ]]];
      x = Map[x[[#]]&, Round[1+(n-1)*k]];
      x -= x[[ 1]];
      x /= x[[-1]];
      x = Transpose[MyPartition[2, N[Transpose[{k, x}]]]];
      x[[2]] = Flatten/@x[[2]];
      x[[2]] =  (Plus@@@x[[2]])/(Length/@x[[2]]);
      Interpolation[Transpose[x], InterpolationOrder->1]];



SavGol[DOrder_, M_, nl_, nr_] := Module[{A, i, j},
      If[DOrder>M,  Return[{}]];
      If[M>(nl+nr), Return[{}]];
      Off[Power::"indet"];
      A = Table[i^j, {i, -nl, nr}, {j, 0, M}]/.Indeterminate->1;
      On[Power::"indet"];
      A = Inverse[Transpose[A].A].Transpose[A];
      Factorial[DOrder]*A[[DOrder+1]]];



SavitzkyGolayFilter[DOrder_, M_, nl_, nr_, data_] := Module[{c, i},
      c = SavGol[DOrder, M, nl, nr];
      If[c=={}, {},
         i = Length[c];
         i = Outer[Plus, Range[i], {0, Length[data]-i}];
         c.Map[Take[data, #]&, i]]];



StringCRC[s_] := Module[{a,c,f,i,j,n,S},
      S = ToCharacterCode[s];
      a = FromDigits[{10, 0, 0, 1},16];        (*  Hilfswert bei gesetztem Bit  *)
      c = FromDigits[{15,15,15,15},16];        (*  Startwert                    *)
      n = Length[S];
      For[i=1,i<=n,i++,
        c = BitXor[c,S[[i]]];
        For[j=1,j<=8,j++,
          f = (BitAnd[c,1]>0);
          c = Quotient[c,2];
          If[f,c=BitXor[c,a]]]];
      c];



UnitConversion[myold_, mynew_] := Module[{new, old, r, S, u, v, x},
      old = StringReplace[myold, " "->""];
      new = StringReplace[mynew, " "->""];
      If[old==""              , Return[{Null,1}]];
      If[old==new             , Return[{old ,1}]];
      If[(old=="-")&&(new==""), Return[{""  ,1}]];
      v = Union[Flatten[Drop[Transpose[UnitConversionTable],-1]]];
      If[Complement[{old,new},v]!={},
        Print["\n    Cannot convert  >", old, "<  to  >", new, "<  [1]\n"];
        Return[{old,1}]];
      r = Map[(Rule@@#)&, Transpose[{v,Table[u[i],{i,Length[v]}]}]];
      S = Append[
            Map[((#[[1]]/.r)==#[[3]]*(#[[2]]/.r))&,UnitConversionTable],
            x==(old/.r)/(new/.r)];
      S = Check[Solve[S,x,v/.r],{}];
      If[Length[S]!=1,
        Print["\n    Cannot convert  >", old, "<  to  >", new, "<  [2]\n"];
        Return[{old,1}]];
      S = S[[1]];
      If[Length[S]!=1,
        Print["\n    Cannot convert  >", old, "<  to  >", new, "<  [3]\n"];
        Return[{old,1}]];
      S = S[[1]];
      If[(S[[1]]!=x)||Not[MemberQ[{Integer,Rational},Head[S[[2]]]]],
        Print["\n    Cannot convert  >", old, "<  to  >", new, "<  [4]\n"];
        Return[{old,1}]];
      {new,S[[2]]}];



TraceableLD[charge_, ldnr_] := Module[{x, y},
      If[    Not[Head[charge]===String ]                                     , Return[False]];
      If[    Not[Head[ldnr  ]===Integer]                                     , Return[False]];
      If[StringLength[charge]!= 11                                           , Return[False]];
      If[Not[(StringTake[charge, 1]=="R")&&(StringTake[charge, {9, 9}]==".")], Return[False]];
      x = Quotient[ldnr, 1000];
      y =      Mod[ldnr, 1000];
      (x>=1)&&(x<=136)&&(y>=1)&&(y<=111)];



TranslateEpiWafer[x_] := Module[{a, b, h, s},
      If[x===Null,                         Return[Null]];
      s = If[Head[x]===String, x, ToString[x]];
      If[StringLength[s         ] !=   11, Return[s]];
      If[StringTake  [s, 1      ] !=  "6", Return[s]];
      h = Table[ToString[a], {a, 48, 57}];
      If[Not[MemberQ[h, a = StringTake[s, {-4, -3}]]], Return[s]];
      If[Not[MemberQ[h, b = StringTake[s,  -2     ]]], Return[s]];
      h = Join@@Transpose[{h, ToString/@(ToExpression/@h-48)}];
      StringJoin[
        "R4",
        StringTake[s, {2, -5}],
        ".",
        Switch@@Prepend[h, a],
        Switch@@Prepend[h, b]]];



RenameCHICHA[nmf_] := If[nmf=={}, {},
    {nmf[[1]],
      Map[
        ReplacePart[
            ReplacePart[#,
              TranslateEpiWafer[#[[2, 1]]], {2, 1}],
              TranslateEpiWafer[#[[2, 4]]], {2, 4}]&,
        nmf[[2]]]}];



ZIPContents[filename_] := Module[{f, i, j, X},
      i = DirectoryName[filename];
      f = {StringJoin["call ", MyHomeBat],
           "@echo on",
           StringTake[i, 2],
           StringJoin["cd ", StringDrop[i, 2]],
           StringJoin[
                "pkunzip -vbn \"",
                StringDrop[filename, StringLength[i]],
                "\" >> ",
                X = StringJoin[MyTempDir, "zipcont.txt"]]};
      If[Run[f = Export[StringJoin[MyTempDir,"tmp.bat"], f, "Lines"]] != 0, Return[{}]];
      DeleteFile[f];
      X = ReadList[f = X, String];
      i = Map[StringPosition[#, "------"] &, X];
      i = Select[Transpose[{Table[j, {j, Length[i]}], i}], (#[[2]] != {}) &];
      If[Length[i] != 2, Return[{}]];
      i = Transpose[i][[1]] + {1, -1};
      X = Map[MyStringPartition[#, {" "}] &, Take[X, i]];
      X = Map[
          {StringJoin @@ Drop[#, 7],
              ToExpression[
                StringReplace[
                  StringJoin["{", #[[6]], ",", #[[7]], ",0}"],
                  {"-" -> ",", ":" -> ","}]],
              ToExpression[#[[2]]]} &, X];
      X = Map[ReplacePart[#, Join[Reverse[Take[#[[2]], 3]], Drop[#[[2]], 3]], 2] &, X];
      X = Map[ReplacePart[#, If[#[[2, 1]] > 80, 1900, 2000] + #[[2, 1]], {2, 1}] &, X];
      DeleteFile[f];
      X];



OldZIPContents[fn_] := Module[{f,n},
    CopyFile[fn,
      n=StringJoin[MyTempDir,StringDrop[fn,StringLength[DirectoryName[fn]]]]];
    f = OpenWrite[StringJoin[MyTempDir,"tmp.bat"]];
    WriteString[f, "@echo off\n"];
    WriteString[f, "call ",MyHomeBat,"\n"];
    WriteString[f, StringTake[MyTempDir,2],"\n"];
    WriteString[f, "cd ",MyTempDir,"\n"];
    WriteString[f, "pkunzip -@l.txt ", n, "\n"];
(*
WriteString[f, "pause\n"];
*)
    Close[f];
    Run[StringJoin[MyTempDir,"tmp.bat"]];
    DeleteFile[StringJoin[MyTempDir,"tmp.bat"]];
    DeleteFile[n];
    {fn,Import[StringJoin[MyTempDir,"l.txt"],"Lines"]}];



LoadSP1[zip_,path_,txt_,endzip_,endfil_,wcols_] := Module[
  {a,c,cols,conv,convtab,extr,fd,fn,fs,H,ht,i,ident,n,name,S,toint,toreal,u},


  toreal[s_] := Module[{y},
      If[Not[Head[s]===String], Return[]];
      If[
        Complement[
            Characters[s],
            {"0","1","2","3","4","5","6","7","8","9",".","+","-","*","^"}]!={},
        Return[]];
      y = Check[ToExpression[s], {}];
      If[MemberQ[{Integer, Real}, Head[y]], y, Null]];


  toint[s_] := Module[{y},
      If[Not[Head[s]===String], Return[]];
      If[
        Complement[
            Characters[s],
            {"0","1","2","3","4","5","6","7","8","9","+","-"}]!={},
        Return[]];
      y = Check[ToExpression[s], {}];
      If[Head[y] === Integer, y, Null]];


  ident = #&;


  extr[t_] :=
    Map[
      StringReplace[
        Check[StringTake[t,#],""],
        {"e+"->"*10^",
         "e-"->"*10^-",
         "E+"->"*10^",
         "E-"->"*10^-",
         " " ->"",
         ht  ->""}]&,
      c];


  conv[x_] := Module[{f,u},
      u = x[[1]]/.convtab;
      If[Head[u]===String,
         Print["    Unrecognized column  ",u, "  encountered!"];
         Return[x]];
      f = u[[1]];
      u = UnitConversion[If[x[[1]]==x[[2]],"",x[[2]]],u[[2]]];
      If[u[[2]]!=1,
         Print["    converting column ",x[[1]],
               " from ",x[[2]]," to ",u[[1]],
               " (factor ",N[u[[2]]],")"]];
      Join[{x[[1]],u[[1]]},u[[2]]*Map[f,Drop[x,2]]]];


  ht   = FromCharacterCode[9];
  cols = Switch[wcols,
    "default",DefaultColumns,
     _,wcols];
  convtab = {
    "SUBMOUNT" -> {toint, ""},
    "CHICHALD" -> {ident, ""},
    "CHICHA"   -> {ident, ""},
    "CHIPOSLD" -> {toint, ""},
    "CHIPOS"   -> {toint, ""},
    "RINGNRLD" -> {ident, ""},
    "CHICHAMD" -> {ident, ""},
    "RINGNRMD" -> {ident, ""},
    "GESAMTB"  -> {toint, ""},
    "BINCLAS"  -> {toint, ""},
    "BINCLASS" -> {toint, ""},
    "FEHLV0U"  -> {toint, ""},
    "FEHLV0G"  -> {toint, ""},
    "FEHLV1G"  -> {toint, ""},
    "FEHLV2G"  -> {toint, ""},
    "FEHLV3G"  -> {toint, ""},
    "FEHLV4G"  -> {toint, ""},
    "KLEB"     -> {toint, ""},
    "LOELINSE" -> {toint, ""},
    "WIREBOND" -> {toint, ""},
    "ABSTAND"  -> {toint, ""},
    "DK"       -> {toreal,""},
    "VERDREH"  -> {toreal,""},
    "LFOCUS"   -> {toreal,""},
    "LSCHIEL"  -> {toreal,""},
    "ETAFMAX"  -> {toreal,""},
    "ETAFMIN"  -> {toreal,""},
    "Gray"     -> {toreal,""},
    "BEW"      -> {ident, ""},
    "POPT25"   -> {toreal,"mW"},
    "ITH25"    -> {toreal,"mA"},
    "E_F25"    -> {toreal,"mW/A"},
    "IF25"     -> {toreal,"mA"},
    "UF125"    -> {toreal,"V"},
    "UF225"    -> {toreal,"V"},
    "RS25"     -> {toreal,"Ohm"},
    "SSAT25"   -> {toreal,""},
    "SVAR25"   -> {toreal,""},
    "LAMBDA25" -> {toreal,"nm"},
    "LOSS1_25" -> {toreal,"nm"},
    "SMSR1_25" -> {toreal,"dB"},
    "SML1_25"  -> {toreal,"dB"},
    "SMR1_25"  -> {toreal,"dB"},
    "KONT25"   -> {toreal,"-"},
    "CHIP25"   -> {toreal,"V"},
    "POPT70"   -> {toreal,"mW"},
    "ITH70"    -> {toreal,"mA"},
    "E_F70"    -> {toreal,"mW/A"},
    "IF70"     -> {toreal,"mA"},
    "UF170"    -> {toreal,"V"},
    "UF270"    -> {toreal,"V"},
    "RS70"     -> {toreal,"Ohm"},
    "SSAT70"   -> {toreal,""},
    "SVAR70"   -> {toreal,""},
    "LAMBDA70" -> {toreal,"nm"},
    "LOSS1_70" -> {toreal,"nm"},
    "SMSR1_70" -> {toreal,"dB"},
    "SML1_70"  -> {toreal,"dB"},
    "SMR1_70"  -> {toreal,"dB"},
    "KONT70"   -> {toreal,"-"},
    "CHIP70"   -> {toreal,"V"},
    "POPT85"   -> {toreal,"mW"},
    "ITH85"    -> {toreal,"mA"},
    "E_F85"    -> {toreal,"mW/A"},
    "IF85"     -> {toreal,"mA"},
    "UF185"    -> {toreal,"V"},
    "UF285"    -> {toreal,"V"},
    "RS85"     -> {toreal,"Ohm"},
    "SSAT85"   -> {toreal,""},
    "SVAR85"   -> {toreal,""},
    "LAMBDA85" -> {toreal,"nm"},
    "LOSS1_85" -> {toreal,"nm"},
    "SMSR1_85" -> {toreal,"dB"},
    "SML1_85"  -> {toreal,"dB"},
    "SMR1_85"  -> {toreal,"dB"},
    "KONT85"   -> {toreal,"-"},
    "CHIP85"   -> {toreal,"V"},
    "POPT95"   -> {toreal,"mW"},
    "ITH95"    -> {toreal,"mA"},
    "E_F95"    -> {toreal,"mW/A"},
    "IF95"     -> {toreal,"mA"},
    "UF195"    -> {toreal,"V"},
    "UF295"    -> {toreal,"V"},
    "RS95"     -> {toreal,"Ohm"},
    "SSAT95"   -> {toreal,""},
    "SVAR95"   -> {toreal,""},
    "LAMBDA95" -> {toreal,"nm"},
    "LOSS1_95" -> {toreal,"nm"},
    "SMSR1_95" -> {toreal,"dB"},
    "SML1_95"  -> {toreal,"dB"},
    "SMR1_95"  -> {toreal,"dB"},
    "KONT95"   -> {toreal,"-"},
    "CHIP95"   -> {toreal,"V"},

      "IMON25" -> {toreal,"mA"},
     "E_MON25" -> {toreal,"A/A"},
    "ID_MON25" -> {toreal,"nA"},

      "IMON85" -> {toreal,"mA"},
     "E_MON85" -> {toreal,"A/A"},
    "ID_MON85" -> {toreal,"nA"},

      "IMON95" -> {toreal,"mA"},
     "E_MON95" -> {toreal,"A/A"},
    "ID_MON95" -> {toreal,"nA"},

    "ACWPT125" -> {toreal, ""},
    "ACWPT185" -> {toreal, ""},
    "ACWPT195" -> {toreal, ""},

    "IOFFS125" -> {toreal,"mA"},
    "OMEGA125" -> {toreal,"GHz"},
     "AMPL125" -> {toreal,"uW"},
    "TAU0_125" -> {toreal,"ns"},
      "A_S125" -> {toreal,"uW"},
    "GAMMA125" -> {toreal,"GHz"},
    "SLOPE125" -> {toreal,"W/s"},
    "INTCP125" -> {toreal,"uW"},
    "FAULT125" -> {toreal,"W²"},

    "IOFFS225" -> {toreal,"mA"},
    "OMEGA225" -> {toreal,"GHz"},
     "AMPL225" -> {toreal,"uW"},
    "TAU0_225" -> {toreal,"ns"},
      "A_S225" -> {toreal,"uW"},
    "GAMMA225" -> {toreal,"GHz"},
    "SLOPE225" -> {toreal,"W/s"},
    "INTCP225" -> {toreal,"uW"},
    "FAULT225" -> {toreal,"W²"},

    "IOFFS325" -> {toreal,"mA"},
    "OMEGA325" -> {toreal,"GHz"},
     "AMPL325" -> {toreal,"uW"},
    "TAU0_325" -> {toreal,"ns"},
      "A_S325" -> {toreal,"uW"},
    "GAMMA325" -> {toreal,"GHz"},
    "SLOPE325" -> {toreal,"W/s"},
    "INTCP325" -> {toreal,"uW"},
    "FAULT325" -> {toreal,"W²"},

    "IOFFS185" -> {toreal,"mA"},
    "OMEGA185" -> {toreal,"GHz"},
     "AMPL185" -> {toreal,"uW"},
    "TAU0_185" -> {toreal,"ns"},
      "A_S185" -> {toreal,"uW"},
    "GAMMA185" -> {toreal,"GHz"},
    "SLOPE185" -> {toreal,"W/s"},
    "INTCP185" -> {toreal,"uW"},
    "FAULT185" -> {toreal,"W²"},

    "IOFFS285" -> {toreal,"mA"},
    "OMEGA285" -> {toreal,"GHz"},
     "AMPL285" -> {toreal,"uW"},
    "TAU0_285" -> {toreal,"ns"},
      "A_S285" -> {toreal,"uW"},
    "GAMMA285" -> {toreal,"GHz"},
    "SLOPE285" -> {toreal,"W/s"},
    "INTCP285" -> {toreal,"uW"},
    "FAULT285" -> {toreal,"W²"},

    "IOFFS385" -> {toreal,"mA"},
    "OMEGA385" -> {toreal,"GHz"},
     "AMPL385" -> {toreal,"uW"},
    "TAU0_385" -> {toreal,"ns"},
      "A_S385" -> {toreal,"uW"},
    "GAMMA385" -> {toreal,"GHz"},
    "SLOPE385" -> {toreal,"W/s"},
    "INTCP385" -> {toreal,"uW"},
    "FAULT385" -> {toreal,"W²"},

    "MODSLO25" -> {toreal,""},
    "MODSLO85" -> {toreal,""},
    "DAMPED25" -> {toreal,""},
    "DAMPED85" -> {toreal,""},
    
    "TIME25"   -> {ident, ""},
    "TIME75"   -> {ident, ""},
    "TIME85"   -> {ident, ""},
    "TIME95"   -> {ident, ""},
    "TIME105"  -> {ident, ""},
    
    "Pmax_201" -> {toreal,"mW"}, 
    "Ith_201"  -> {toreal,"mA"}, 
    "Dqe_201"  -> {toreal,"W/A"}, 
    "Rs_201"   -> {toreal,"Ohm"}, 
    "UF_201"   -> {toreal,"V"},
    "BEW_201"  -> {ident, ""},
    
    "Pmax_101" -> {toreal,"mW"}, 
    "Ith_101"  -> {toreal,"mA"}, 
    "Dqe_101"  -> {toreal,"W/A"}, 
    "Rs_101"   -> {toreal,"Ohm"}, 
    "UF_101"   -> {toreal,"V"},
    "BEW_101"  -> {ident, ""}
    };

  a = StringPosition[txt,"_"][[1,1]];
  a = StringJoin[StringTake[txt,a-1],"*",StringDrop[txt,a]];
  If[zip,
     n = FileNames[{StringJoin[a,"*.",endzip]},{path}];
     If[n=={},
        Print["    No zip file for  ",a,"  found in  ",path];
        Return[{}]];
     n  = Sort[Map[{ToExpression[StringDrop[#,StringPosition[#,"."][[-1,2]]+1]],#}&,n]][[-1,2]];
     fn = n;
     Print["    unzipping  ",n];
     CopyFile[fn,
       n=StringJoin[MyTempDir,StringDrop[n,StringLength[DirectoryName[n]]]]];
     f = OpenWrite[StringJoin[MyTempDir,"tmp.bat"]];
     WriteString[f,"@echo off\n"];
     WriteString[f,"call ",MyHomeBat,"\n"];
     WriteString[f,StringTake[MyTempDir,2],"\n"];
     WriteString[f,"cd ",MyTempDir,"\n"];
     WriteString[f,"pkunzip -o ",n,"\n"];
(*
     WriteString[f,"pause\n"];
*)
     Close[f];
     Run[StringJoin[MyTempDir,"tmp.bat"]];
     DeleteFile[StringJoin[MyTempDir,"tmp.bat"]];
     DeleteFile[n]];
  n = FileNames[{StringJoin[a,"*.",endfil]},{If[zip,MyTempDir,path]}];
  S = Length[n];
  If[S==0,
     Print["    No file  ",StringJoin[a,"*.",endfil],"  found in  ",If[zip,MyTempDir,path]];
     Return[{}]];
  If[S>1,
     Print["    ",S," files  ",
           StringJoin[a,"*.",endfil],
           "  found in  ",
           If[zip,MyTempDir,path]]];
  n = Sort[Map[{MyDateConv[FileDate[#]],#}&,n]][[-1,2]];
  If[Not[zip],fn=n];
  fd = ToString[MyDateConv[FileDate[     fn]]];
  fs = ToString[           FileByteCount[fn]];
  Print["    loading   ",n];
  S = ReadList[n,String];
  If[zip,
     Print["    deleting  ",n];
     DeleteFile[n]];
  name = StringReplace[
           StringJoin[
             StringJoin@@Table["0",{i,4-StringLength[S[[9 ]]]}],S[[9]],"_",
             StringJoin@@Table["0",{i,2-StringLength[S[[10]]]}],S[[10]]],
           {" "->"",ht->""}];
  If[StringReplace[a,"*"->"_"]!=name,
     Print["      INCONSISTENT FILE NAME:    >",name,"<"];
     Return[{}]];
  a = ToExpression[S[[16]]];
  If[Head[a]!=Integer,Return[{}]];
  Print["      contains ",Length[S]-a-16," data lines with ",a," columns"];
  c = Map[MyStringPartition[
            StringReplace[#, {"["->"", 
                              "]"->""}],
            {" ", ht}]&, 
          Take[S, {17, a+16}]];
  u = Map[If[Length[#]<2,
             #[[1]]->"",
             #[[1]]->#[[2]]]&,
          c];
  c = Map[#[[1]]&,c];
  If[cols=={},cols=c];
  If[(i=Position[c,"LDNR"   ])!={}, Scan[(c[[#[[1]]]]="CHIPOSLD")&,i]];
  If[(i=Position[c,"CHIP_ID"])!={}, Scan[(c[[#[[1]]]]="CHIPOSLD")&,i]];
  n = Length[Complement[cols,c]];
  If[n>0,
     Print["    ",n," columns missing:"];
     Scan[
       If[Not[MemberQ[c,#]],
          Print["        ",#]]&,
       cols];
     If[(n=Length[Intersection[c,cols]])==0,
        Print["    No wanted data columns found. Exiting.\n"];
        Return[{}],
        Print["    ",n," wanted data columns found ..."]]];
  If[(n=Complement[cols,Map[#[[1]]&,convtab]])!={},
     Print["\n    ",Length[n]," columns cannot be casted:"];
     Scan[Print["        ",#]&,Sort[n]];
     Print["    Exiting.\n"];
     Return[{}]];
  c = Map[Position[c,#]&,cols];
  c = Map[If[#=={},0,#[[1,1]]]&,c];
  c = Map[If[#==0,{},{11*#-10,11*#}]&,c];
  H = Take[S,a+16];
  S = Drop[S,a+16];
  If[S=={},Return[{}]];
  Print["        extracting ..."];
  S = Map[extr,S];
  If[S=={},Return[{}]];
  Print["        casting ..."];
  S = Transpose[Map[conv,Transpose[Join[{cols,cols/.u},S]]]];
  If[S=={},Return[{}]];
  Print[""];
  {name,S,Join[{fn,fd,fs},H]}];



ReadNMF[save_,path_,txt_] := Module[{a,c,f,H,n,outpath,S,x,X,Y,Z},
      X = LoadSP1[False,path,txt,"","nmf",
                   {"SUBMOUNT","CHICHALD","CHIPOSLD","RINGNRLD","CHICHAMD","RINGNRMD"}];
      If[Length[X]!=3, Return[{}]];
      If[X[[2,1]]!={"SUBMOUNT","CHICHALD","CHIPOSLD","RINGNRLD","CHICHAMD","RINGNRMD"},
         Return[{}]];
(*
Return[X];
*)
      n = X[[1]];
      outpath = SMWaferMapPath;
      If[(S=Check[Map[{ToExpression[#[[1]]],#[[2]],#[[4]]}&,Drop[X[[2]],2]],{}])=={},
         Return[{}]];
      a = Complement[Union[Transpose[S][[2]]],{Null,"","-","-1","0","0.000000000"}];
      f[x_] := Select[S,(#[[2]]==x)&];
      S = Map[f,a];
      a = Reverse[Sort[Map[{Length[#],#[[1,2]]}&,S]]];
      c = {Hue[0.5],
           Hue[0.3],
           Hue[0.16],
           Hue[0.1],
           Hue[0],
           Hue[0.88],
           Hue[0.68],
           GrayLevel[0.7],
           GrayLevel[0.4],
           GrayLevel[0.0],
           GrayLevel[1.0],
           GrayLevel[0.9],
           GrayLevel[0.8],
           GrayLevel[0.6],
           GrayLevel[0.5],
           GrayLevel[0.3],
           GrayLevel[0.2],
           GrayLevel[0.1]};
      If[Length[a]>Length[c],
         Print["    More than ",Length[c]," epi wafers assembled!  (",Length[a],")"];
         Return[{}]];
      a = Sort[
            Transpose[Append[Transpose[a],Take[c,Length[a]]]],
            OrderedQ[{#2[[2]],#1[[2]]}]&];
      c = Sort[Map[(#[[2]]->#[[3]])&,a]];
      Y = Join@@S;
      S = Map[{#[[2]]/.c,{Quotient[#[[1]],SMDiv],Mod[#[[1]],SMDiv]}}&,Y];
      S = Map[
            ReplacePart[
              #,
              Rectangle[{#[[2,1]]-0.9,0.1-#[[2,2]]},{#[[2,1]]-0.1,0.9-#[[2,2]]}],
              2]&,
            S];
      If[save,
         Y = Transpose[Drop[Transpose[Y],1]];
         Y = Sort[Map[Prepend[Append[#,Count[Y,#]],n]&,Union[Y]]];
         Y = Map[ReplacePart[#,TranslateEpiWafer[#[[2]]],2]&,Y];
         f = StringJoin[EpiWaferList,".csv"];
         Z = Check[Import[f],{{1,1,1,1,1,1}}];
         If[(Length[Z]==(1+Z[[1,6]]))&&(Min[Map[Length,Z]]>=4),
            DeleteFile[StringJoin[EpiWaferList,".txt"]];
            CopyFile[f,StringJoin[EpiWaferList,".txt"]];
            Z = Map[Map[If[Head[#]===String,#,ToString[#]]&,#]&,Drop[Z,1]];
            H = Map[Take[#,3]&,Z];
            Y = Select[Y,Not[MemberQ[H,Take[#,3]]]&];
            Z = Sort[Map[Take[#,Max[4,Min[5,Length[#]]]]&,Join[Y,Z]]];
            Z = Prepend[Z,
                  {"SM-Wafer",
                   "Epicharge",
                   "Ringnummer",
                   "Stückzahl",
                   "Kommentar",
                   Length[Z]}];
            f = Export[f,Z];
            Print["    ",Length[Y]," entries added to  ",f, "\n"],
            Print["\n        ",f,"  is corrupted, no update made.\n"]]];
      S = Graphics[{{WaferColor,Rectangle[{0,0},{SMXSize,-SMYSize}]},S},
            AspectRatio     -> 1,
            Axes            -> False,
            DisplayFunction -> Identity,
            Frame           -> True,
            FrameLabel      -> {"Submount  X","- Submount  Y"},
            PlotLabel       -> StringJoin[n," :        ",ToString[Length[S]],"  Lasers"],
            PlotRange       -> All,
            LabelStyle       -> MyTS];
      S = GraphicsRow[{S,
        Graphics[{
            Table[
              {{a[[i,3]],Rectangle[{0.01,i-0.85},{0.99,i-0.15}]},
                Text[
                    StringJoin[
                        TranslateEpiWafer[a[[i,2]]],
                        "        ( ",
                        ToString[a[[i,1]]]," )"],
                    {1.5,i-0.5},{-1,0},LabelStyle->MyTS]},
              {i,Length[a]}],
            {GrayLevel[1],Point[{-2,0}],Point[{15,Length[a]}]}},
            AspectRatio     -> Automatic,
            Axes            -> False,
            DisplayFunction -> Identity,
            Frame           -> False,
            PlotRange       -> All]},
        Spacings -> 0,
        DisplayFunction -> $DisplayFunction,
        ImageSize       -> 1026];
      Show[S];
      If[save,
         a = 800;
         c = StringJoin[MyTempDir,"mytmpimage.tif"];
         S = Import[Export[c, S]];
         DeleteFile[c];
         S = ReplacePart[S,Transpose[Take[Transpose[S[[1,1]]],a]],{1, 1}];
         S[[2,2,1  ]] = a;
         S[[1,2,2,1]] = a;
         Print["\n    wrote  ",Export[StringJoin[outpath,n,"_CHICHALD.gif"],S]]];
      X = Check[ToExpression[Drop[X[[2]],2]],{}];  (* vereinfachend werden nur Integers erwartet *)
      If[X=={}, Return[{}]];
      X = Select[X,((#[[1]]>0)&&(#[[2]]>0)&&(#[[4]]>0)&&(#[[5]]>0)&&(#[[6]]>0))&];
      X = RenameCHICHA[{n,
       Sort[
        Join[
          Map[(#->{Null,Null,Null,Null,Null})&,
            Complement[
              Map[(SMDiv*#[[1]]+#[[2]])&,
                Transpose[ExistingPositions][[1]]],
              Transpose[X][[1]]]],
          Map[(#[[1]]->Drop[#,1])&,X]]]}];
      If[save,
         n = StringJoin[MathematicaDataPath,n,"_NMF.dat"];
         Put[X,n];
         Print["    wrote  ",n,"\n"]];
      X];



ReadBHNMF[save_,path_,txt_] := Module[{a,c,f,H,n,outpath,S,x,X,Y,Z},
      Print["\n\n    THIS IS THE RELAXED VERSION. FOR BIGHIT WAFERS ONLY!\n\n"];
      X = LoadSP1[False,path,txt,"","nmf",
                   {"SUBMOUNT","CHICHALD","CHIPOSLD","RINGNRLD","CHICHAMD","RINGNRMD"}];
      If[Length[X]!=3, Return[{}]];
      If[X[[2,1]]!={"SUBMOUNT","CHICHALD","CHIPOSLD","RINGNRLD","CHICHAMD","RINGNRMD"},
         Return[{}]];
      n = X[[1]];
      outpath = SMWaferMapPath;
      If[(S=Check[Map[{ToExpression[#[[1]]],#[[2]],#[[4]]}&,Drop[X[[2]],2]],{}])=={},
         Return[{}]];
      a = Complement[Union[Transpose[S][[2]]],{Null,"","-","-1","0","0.000000000"}];
      f[x_] := Select[S,(#[[2]]==x)&];
      S = Map[f,a];
      a = Reverse[Sort[Map[{Length[#],#[[1,2]]}&,S]]];
      c = {Hue[0.5],
           Hue[0.3],
           Hue[0.16],
           Hue[0.1],
           Hue[0],
           Hue[0.88],
           Hue[0.68],
           GrayLevel[0.7],
           GrayLevel[0.4],
           GrayLevel[0.0],
           GrayLevel[1.0],
           GrayLevel[0.9],
           GrayLevel[0.8],
           GrayLevel[0.6],
           GrayLevel[0.5],
           GrayLevel[0.3],
           GrayLevel[0.2],
           GrayLevel[0.1]};
      If[Length[a]>Length[c],
         Print["    More than ",Length[c]," epi wafers assembled!  (",Length[a],")"];
         Return[{}]];
      a = Sort[
            Transpose[Append[Transpose[a],Take[c,Length[a]]]],
            OrderedQ[{#2[[2]],#1[[2]]}]&];
      c = Sort[Map[(#[[2]]->#[[3]])&,a]];
      Y = Join@@S;
      S = Map[{#[[2]]/.c,{Quotient[#[[1]],SMDiv],Mod[#[[1]],SMDiv]}}&,Y];
      S = Map[
            ReplacePart[
              #,
              Rectangle[{#[[2,1]]-0.9,0.1-#[[2,2]]},{#[[2,1]]-0.1,0.9-#[[2,2]]}],
              2]&,
            S];
      If[save,
         Y = Transpose[Drop[Transpose[Y],1]];
         Y = Sort[Map[Prepend[Append[#,Count[Y,#]],n]&,Union[Y]]];
         Y = Map[ReplacePart[#,TranslateEpiWafer[#[[2]]],2]&,Y];
         f = StringJoin[EpiWaferList,".csv"];
         Z = Check[Import[f],{{1,1,1,1,1,1}}];
         If[(Length[Z]==(1+Z[[1,6]]))&&(Min[Map[Length,Z]]>=4),
            DeleteFile[StringJoin[EpiWaferList,".txt"]];
            CopyFile[f,StringJoin[EpiWaferList,".txt"]];
            Z = Map[Map[If[Head[#]===String,#,ToString[#]]&,#]&,Drop[Z,1]];
            H = Map[Take[#,3]&,Z];
            Y = Select[Y,Not[MemberQ[H,Take[#,3]]]&];
            Z = Sort[Map[Take[#,Max[4,Min[5,Length[#]]]]&,Join[Y,Z]]];
            Z = Prepend[Z,
                  {"SM-Wafer",
                   "Epicharge",
                   "Ringnummer",
                   "Stückzahl",
                   "Kommentar",
                   Length[Z]}];
            f = Export[f,Z];
            Print["    ",Length[Y]," entries added to  ",f, "\n"],
            Print["\n        ",f,"  is corrupted, no update made.\n"]]];
      S = Graphics[{{WaferColor,Rectangle[{0,0},{SMXSize,-SMYSize}]},S},
            AspectRatio     -> 1,
            Axes            -> False,
            DisplayFunction -> Identity,
            Frame           -> True,
            FrameLabel      -> {"Submount  X","- Submount  Y"},
            PlotLabel       -> StringJoin[n," :        ",ToString[Length[S]],"  Lasers"],
            PlotRange       -> All,
            LabelStyle       -> MyTS];
      S = GraphicsRow[{S,
        Graphics[{
            Table[
              {{a[[i,3]],Rectangle[{0.01,i-0.85},{0.99,i-0.15}]},
                Text[
                    StringJoin[
                        TranslateEpiWafer[a[[i,2]]],
                        "        ( ",
                        ToString[a[[i,1]]]," )"],
                    {1.5,i-0.5},{-1,0},LabelStyle->MyTS]},
              {i,Length[a]}],
            {GrayLevel[1],Point[{-2,0}],Point[{15,Length[a]}]}},
            AspectRatio     -> Automatic,
            Axes            -> False,
            DisplayFunction -> Identity,
            Frame           -> False,
            PlotRange       -> All]},
        Spacings -> 0,
        DisplayFunction -> $DisplayFunction,
        ImageSize       -> 1026];
      Show[S];
      If[save,
         a = 800;
         c = StringJoin[MyTempDir,"mytmpimage.tif"];
         S = Import[Export[c, S]];
         DeleteFile[c];
         S = ReplacePart[S,Transpose[Take[Transpose[S[[1,1]]],a]],{1, 1}];
         S[[2,2,1  ]] = a;
         S[[1,2,2,1]] = a;
         Print["\n    wrote  ",Export[StringJoin[outpath,n,"_CHICHALD.gif"],S]]];
      X = Check[ToExpression[Drop[X[[2]],2]],{}];  (* vereinfachend werden nur Integers erwartet *)
      If[X=={}, Return[{}]];
      X = Select[X,((#[[1]]>0)&&(#[[2]]>0)&&(#[[4]]>0))&];
      X = RenameCHICHA[{n,
       Sort[
        Join[
          Map[(#->{Null,Null,Null,Null,Null})&,
            Complement[
              Map[(SMDiv*#[[1]]+#[[2]])&,
                Transpose[ExistingPositions][[1]]],
              Transpose[X][[1]]]],
          Map[(#[[1]]->Drop[#,1])&,X]]]}];
      If[save,
         n = StringJoin[MathematicaDataPath,n,"_NMF.dat"];
         Put[X,n];
         Print["    wrote  ",n,"\n"]];
      X];



CountColumn[M_,c_] := Module[{n,p},
      p = Position[M[[2,1]],c];
      If[p=={},
        Print["\n    Column  ",c, "  is missing.\n"];
        Return[{c,0,Length[M[[2]]]-2}]];
      p = p[[1,1]];
      p = Transpose[Drop[M[[2]],2]][[p]];
      n = Length[p];
      p = {n-Count[p,Null],n};
      If[Equal@@p, Print["    Column  ",c, "  is complete."];];
      Prepend[p,c]];



ExtractColumn[M_,c_,wu_,r_] := Module[{p,u,Y},
      p = Flatten[{Position[M[[2,1]],"SUBMOUNT"],
                   Position[M[[2,1]],c]}];
      If[Length[p]!=2,
         Print["    Column  ",c,"  cannot be extracted."];
         Return[{}]];
      u = M[[2,2,p[[2]]]];
      If[MemberQ[{Null,""},u],
         u = "-"];
      u = If[wu===-1, {u, 1}, UnitConversion[u,wu]];
      Y = Transpose[Drop[M[[2]],2]];
      Y = Map[Y[[#]]&,p];
      Y = Select[
            Transpose[
              {Map[{Quotient[#,SMDiv],Mod[#,SMDiv]}&,Y[[1]]],
               u[[2]]*Y[[2]]}],
            Not[#[[2]]===Null]&];
      p = Interval[r];
      {Join[M[[1]],{c,u[[1]]}],
        If[Length[r]==2,Select[Y,IntervalMemberQ[p,#[[2]]]&],Y]}];



ExtractTDrift[M_,c_,wu_,r_,T1_,T2_,q_] := Module[{p,u,Y},
      p = Flatten[{Position[M[[2,1]],"SUBMOUNT"],
                   Position[M[[2,1]],StringJoin[c,T1]],
                   Position[M[[2,1]],StringJoin[c,T2]]}];
      If[Length[p]!=3,
         Print["    Drift of  ",c,"  cannot be extracted."];
         Return[{}]];
      u = M[[2,2,p[[2]]]];
      If[MemberQ[{Null,""},u],
         u = "-"];
      u = UnitConversion[u,wu];
      Y = Transpose[Drop[M[[2]],2]];
      Y = Map[Y[[#]]&,p];
      Y = Transpose[
            ReplacePart[
              Y,
              Map[{Quotient[#,SMDiv],Mod[#,SMDiv]}&,Y[[1]]],
              1]];
      Y = Select[Y, (Intersection[#, {Null, "NaN", 0, N[0]}]=={})&];
      If[Y=={}, Return[Y]];
      Y = Transpose[Y];
      Y[[2]] *= u[[2]];
      Y[[3]] *= u[[2]];
      Y = Transpose[Y];
      If[Length[r]==2,
        p = Interval[r];
        Y = Select[Y,
              (IntervalMemberQ[p, #[[2]]]&&
               IntervalMemberQ[p, #[[3]]]  )&]];
      Y = If[q, Map[{#[[1]], #[[3]]/#[[2]]}&,Y],
                Map[{#[[1]], #[[3]]-#[[2]]}&,Y]];
      {Join[M[[1]],{StringJoin["§",c],If[q,"ratio",u[[1]]]}],Y}];



MergeData[nmf_,sp1_] := Module[{A, B, c, i, n, p, r, s, u, v, y},
      If[nmf[[1]]!=sp1[[1]],Return[{}]];
      A = sp1[[2,1]];
      s = Position[A,"SUBMOUNT"];
      c = Position[A,"CHICHALD"];
      p = Position[A,"CHIPOSLD"];
      r = Position[A,"RINGNRLD"];
      u = Position[A,"CHICHAMD"];
      v = Position[A,"RINGNRMD"];
      If[(c=={})||(p=={})||(r=={})||(s=={})||(u=={})||(v=={}),Return[{}]];
      c = c[[1,1]];
      p = p[[1,1]];
      r = r[[1,1]];
      s = s[[1,1]];
      u = u[[1,1]];
      v = v[[1,1]];
      A = sp1[[2]];
      B = nmf[[2]];
      n = Length[A];
      For[i=3,i<=n,i++,
        y = A[[i,s]]/.B;
        A[[i,c]] =                                    y[[1]]       ;
        A[[i,p]] = If[Head[y[[2]]]===Integer,ToString[y[[2]]],Null];
        A[[i,r]] =                           ToString[y[[3]]]      ;
        A[[i,u]] =                                    y[[4]]       ;
        A[[i,v]] =                           ToString[y[[5]]]      ;];
      {sp1[[1]],A,sp1[[3]]}];



SaveProberData[M_,time_,comment_] := Module[{epath,f,H,mpath,t,ts},
      epath = ExcelDataPath;
      mpath = MathematicaDataPath;
      ts = ToExpression[
          StringDrop[
            StringReplace[
              If[time=="","0h",time],
              {"h"->"*3600+","m"->"*60+","s"->"+"}],
            -1]];
      ts -= 3600*(t=Quotient[ts,3600]);
      t  = {t,Quotient[ts,60],Mod[ts,60]};
      ts = Map[ToString,t];
      ts = StringJoin[
          StringJoin@@Table["0",{f,4-StringLength[ts[[1]]]}],ts[[1]],"-",
          StringJoin@@Table["0",{f,2-StringLength[ts[[2]]]}],ts[[2]],"-",
          StringJoin@@Table["0",{f,2-StringLength[ts[[3]]]}],ts[[3]]];
      f = StringJoin[
          M[[1]],
          "@(",ts,")",
          If[comment=="","",StringJoin["{",comment,"}"]]];
      mpath = StringJoin[mpath,f,".dat"];
      Put[ReplacePart[M,{M[[1]],t,comment},1],mpath];
      Print["\n    wrote  ",mpath];
      H = Select[M[[3]],(#!="")&];
      H = Map[{#}&,Prepend[H,1+Length[H]]];
      epath = StringJoin[epath,f,".csv"];
      Export[epath,
        Join[H,
          Drop[
            ReplacePart[
              M[[2]],
              Map[If[MemberQ[{Null,"","-"},#[[2]]],
                     #[[1]],
                     StringJoin[#[[1]]," (",#[[2]],")"]]&,
                  Transpose[Take[M[[2]],2]]],
              2],
            1]]];
      Print["    wrote  ",epath,"\n"];
      mpath];



SMWaferMap[save_, A_, csr_, hr_] := Module[
    {a, b, f, G, H, i, l1, l2, l3, marker, mycf, n, path, pn, r, S, v, V, x},

      marker[p_,c_] := {c,Rectangle[{p[[1]]-1,1-p[[2]]},{p[[1]],-p[[2]]}]};

      mycf[v_] := Hue[0.75*(1-x)]/.x->Max[0,Min[1,(v+r[[1]])*r[[2]]]];

      If[A[[2]]=={},Return[]];
      If[Length[a=Union[Transpose[A[[2]]][[2]]]]==1,
         Print["\n    Constant value:    ",A[[1,4]]," =  ",a[[1]]," ",A[[1,5]],"\n"];
         Return[]];
      path = StringJoin[SMWaferMapPath,A[[1,1]],"\\"];
      If[save,MakeDir[path]];
      pn = A[[1, 4]];
      If[StringTake[pn, 1]=="§",
         pn = StringJoin["Temp. Drift  ", StringDrop[pn, 1]]];
      If[StringTake[pn,-1]=="_",
         pn = StringDrop[pn,-1]];
      If[save,
        f = Map[ToString, A[[1, 2]]];
        f = StringJoin[
            StringJoin @@ Table["0", {i, 4 - StringLength[f[[1]]]}], f[[1]],"-",
            StringJoin @@ Table["0", {i, 2 - StringLength[f[[2]]]}], f[[2]], "-",
            StringJoin @@ Table["0", {i, 2 - StringLength[f[[3]]]}], f[[3]]];
        f = StringJoin[path,
            A[[1, 1]], "@(", f, ")",
            If[A[[1, 3]] == "", "", StringJoin["{", A[[1, 3]], "}"]],
            "_", StringReplace[pn, "Temp. Drift  " -> "TD_"], ".gif"]];
      l3 = StringJoin[
          A[[1, 1]], " @ ",
          RealForm[N[1/{1, 60, 3600}].A[[1, 2]], 3, 1], " h",
          If[A[[1, 3]] == "", "", StringJoin["    [", A[[1, 3]], "]"]]];
      l1 = StringJoin[pn, "    ", l3];
      l2 = StringJoin[pn, "  (", A[[1, 5]], ")"];
      V = Transpose[A[[2]]][[2]];
      v = Map[InterpolatedQuantile[V, #] &, {0.02, 0.98}];
      r = If[csr == {}, v, csr];
      r = {-r[[1]], 1/(r[[2]] - r[[1]])};

      b = 4;
      S = StringJoin["Values     ", ToString[Length[V]]];
      a = SetPrecision[v,b];
      S = StringJoin[S, "\n96%-Range [",
          ToString[a[[1]]], ",", ToString[a[[2]]], "]"];
      a = SetPrecision[Quartiles[V],b+1];
      S = StringJoin[S, "\nQuartiles [",
          ToString[a[[1]]], ",",
          ToString[a[[2]]], ",",
          ToString[a[[3]]], "]"];
      S = StringJoin[S, "\nSkewness   ",
          ToString[SetPrecision[Skewness[a],b]]];
      a = Interval[v];
      a = Select[V, IntervalMemberQ[a, #] &];
      S = StringJoin[S, "\nTrmdMean   ",
          ToString[SetPrecision[Mean[a],b]]];
      S = StringJoin[S, "\nTrmdStDev  ",
          ToString[SetPrecision[StandardDeviation[a],b]]];

      G = Graphics[{
            {WaferColor, Rectangle[{0, 0}, {SMXSize, -SMYSize}]},
            Map[marker[#[[1]], mycf[#[[2]]]] &, A[[2]]]},
          AspectRatio -> 1,
          Axes -> False,
          DisplayFunction -> Identity,
          Frame -> True,
          FrameLabel -> {"Submount  X", "- Submount  Y"},
          PlotLabel -> l1,
          PlotRange -> All,
          LabelStyle -> MyTS];

      H = Histogram[V,
            DisplayFunction -> Identity,
            HistogramRange -> If[hr == {}, Automatic, hr]][[1]];
      n = 250;
      H = Select[Flatten[H], (Head[#] == Rectangle) &];
      a = Map[Sort, Transpose[Flatten[Map[(List @@ #) &, H], 1]]];
      a = Map[Drop[#, {2, -2}] &, a];
      b = N[a[[1, 1]] + Table[i, {i, 0, n}]*(a[[1, 2]] - a[[1, 1]])/n];
      b = Transpose[{Drop[b, -1], Drop[b, 1]}];
      b = Map[{mycf[0.5*Plus @@ #], Rectangle @@ Transpose[{#, 1.01*a[[2]]}]} &,b];
      H = Map[ReplacePart[#, 1.02*a[[2, 2]], {1, 2}] &, H];
      H = Map[ReplacePart[
                #,
                If[#[[2, 2]] > 0.5, #[[2, 2]], Min[-1, -0.005*a[[2, 2]]]],
                {2,2}]&,
              H];
      i = 0.005*(a[[1, 2]] - a[[1, 1]]);
      H[[ 1, 1, 1]] -= i;
      H[[-1, 2, 1]] += i;
      H = Prepend[H, GrayLevel[1]];
      H = Graphics[{b, H,
            Text[S, Scaled[{0.99, 0.97}], {1, 1}, {1, 0},
                 LabelStyle -> (MyTS /. {"Arial" -> "Courier"})]},
          AspectRatio -> 1,
          Axes -> False,
          DisplayFunction -> Identity,
          Frame -> True,
          FrameLabel -> {l2, "Values"},
          PlotLabel -> l3,
          PlotRange -> All,
          LabelStyle -> MyTS];

      G = Show[
          GraphicsRow[{G, H}, Spacings -> 0.1],
          DisplayFunction -> If[ShowSMWaferMap, $DisplayFunction, Identity],
          ImageSize -> 800];
      If[save,Print["    wrote  ",Export[NoBlanks[f], G], "\n"]];
      G];



CorrStat[data_] := Module[{h, plt, r, S, T},

      plt[x_, s_, lab_] := Histogram[x,
          DisplayFunction -> Identity,
          Epilog -> Map[
              Text[
                  StringJoin[#[[2]], ToString[SetPrecision[#[[3]], 3]]],
                  Scaled[{0.05, #[[1]]}], {-1, 1}, {1, 0},
                  LabelStyle -> (T/.{"Arial" -> "Courier"})] &,
              {{0.95, "Mean     "  , s[[1]]},
               {0.85, "StDev    "  , s[[2]]},
               {0.75, "\"3sigma\" ", s[[3]]}}],
          Frame      -> True,
          FrameLabel -> {lab, "Frequency"},
          PlotLabel  -> StringJoin["n = ",ToString[Length[x]]],
          PlotRange  -> All,
          LabelStyle  -> T];

      T = {FontFamily -> "Arial",
           FontSlant  -> "Plain",
           FontWeight -> "Plain",
           FontSize   -> 11};
      r = Map[
          Interval[{#[[2, #[[1, 1]]]], #[[2, #[[1, 2]]]]}] &,
          Map[{Round[{0.025, 0.975}*Length[#]], #} &,
            Map[Sort, Transpose[data]]]];
      h = Select[data,
          (IntervalMemberQ[r[[1]], #[[1]]] &&
           IntervalMemberQ[r[[2]], #[[2]]]   ) &];
      h = Transpose[Map[{-Subtract@@#, Plus@@#}&, h]];
      h[[2]] = Select[N[h[[1]]/h[[2]]], (Head[#]===Real)&];
      S = Map[
          {Mean[#],
           StandardDeviation[#],
           (InterpolatedQuantile[#, 0.9986501019683699   ] -
            InterpolatedQuantile[#, 0.0013498980316300928]  )/2,
           {Min[#],Max[#]}}&,
          h];
      {S, GraphicsColumn[
          {plt[h[[1]], S[[1]], "Difference"],
           plt[h[[2]], S[[2]], "Contrast"]}]}];



CorrelationPlot[X_, Y_, is_] := Module[{A, B, G, L, S},

      L := StringJoin[
            #[[1]], "@", RealForm[N[1/{1, 60, 3600}].#[[2]], 3, 1], "h",
            If[#[[3]] == "", "", StringJoin[" [", #[[3]], "]"]],":    ", #[[4]],
            If[MemberQ[{Null, "", " "}, #[[5]]], "",StringJoin["  (", #[[5]], ")"]]] &;

      If[X[[1,1]]!=Y[[1,1]],Return[{}]];
      If[(X[[2]]=={})||
         (Y[[2]]=={})  ,    Return[{}]];
      A = Map[(Rule@@#)&, X[[2]]];
      B = Map[(Rule@@#)&, Y[[2]]];
      S = Intersection[
          Transpose[X[[2]]][[1]],
          Transpose[Y[[2]]][[1]]];
      S = {S/.A, S/.B};
      S = Select[Transpose[S], (Complement[Head/@#, {Integer, Real}]==={})&];
      If[S=={}, Return[{}]];
      If[is,
        A = Join@@Transpose[S];
        A = {Min[A], Max[A]};
        B = 0.05*(A[[2]]-A[[1]]);
        A += {-B, B}];
      G = Graphics[
          {If[is,
              {RGBColor[0, 1, 0], Thickness[0.003],Line[{{A[[1]], A[[1]]}, {A[[2]], A[[2]]}}]},
               RGBColor[0, 0, 0]],
           {RGBColor[0, 0, 1], PointSize[0.01], Map[Point, S]}},
        AspectRatio     -> If[is, Automatic, 1],
        Frame           -> True,
        FrameLabel      -> Map[L, {X[[1]], Y[[1]]}],
        ImageSize       -> 400,
        PlotRange       -> If[is, {A, A}, All],
        LabelStyle       -> MyTS];
      S = If[is,
             A = CorrStat[S];
             G = GraphicsRow[{G,A[[2]]},ImageSize->800];
             {S, A[[1]]},
             {S}];
      Show[G];
      S];



PairCorrelations[data_, wmaps_] := Module[{A, f, i, j, n, w, X},
      If[(X=Select[data,(#     !={})&])=={},Return[{}]];
      If[(X=Select[X   ,(#[[2]]!={})&])=={},Return[{}]];
      If[wmaps, Scan[SMWaferMap[False, #, {}, {}] &, X]];
      If[Length[X]<2,Return[{}]];
      If[Length[Union[Map[Drop[#[[1]], {3, 3}] &, X]]] != 1,
         Return[{}]];
      f = Map[ToString, X[[1, 1, 2]]];
      f = StringJoin[X[[1, 1, 1]], "@(",
          StringJoin[
            StringJoin @@ Table["0", {i, 4 - StringLength[f[[1]]]}], f[[1]], "-",
            StringJoin @@ Table["0", {i, 2 - StringLength[f[[2]]]}], f[[2]], "-",
            StringJoin @@ Table["0", {i, 2 - StringLength[f[[3]]]}], f[[3]], ")"]];
      A = Transpose[
          Map[
            CorrelationPlot[X[[#[[1]]]], X[[#[[2]]]], True] &,
            Reverse[Join@@Table[{i, j}, {i, Length[X]}, {j, 1, i - 1}]]]];
      w = Map[Length, A[[1]]];
      w = N[w/(n = Plus @@ w)];
      A = Map[
          {#[[1]]/{2, Sqrt[2], Sqrt[2], 2},
           #[[2]]*{1, Sqrt[2], Sqrt[2], 1}*100}&,
          A[[2]]];
      A = Transpose[Map[Flatten, A]];
      {f,
       X[[1, 1, 4]],
       X[[1, 1, 5]],
       Length[X],
       Plus @@ Map[Length[#[[2]]] &, X],
       n,
       Max[Abs[A[[1]]]], 3*w.A[[2]], w.A[[3]], Max[Abs[Join[A[[4]],A[[5]]]]],
       Max[Abs[A[[6]]]], 3*w.A[[7]], w.A[[8]], Max[Abs[Join[A[[9]],A[[10]]]]]}];



AccuracyReport[X_, wmaps_] := Module[{allmaps, Y},

  allmaps[T_] :=
    {PairCorrelations[Map[ExtractColumn[#,StringJoin["ITH"   ,T],"mA"  ,{0.1  ,1000}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["E_F"   ,T],"mW/A",{0.1  ,1000}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["IF"    ,T],"mA"  ,{0.1  ,1000}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["UF1"   ,T],"V"   ,{0.1  , 100}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["UF2"   ,T],"V"   ,{0.1  , 100}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["RS"    ,T],"Ohm" ,{0.1  ,1000}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["SSAT"  ,T],""    ,{          }]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["SVAR"  ,T],""    ,{          }]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["LAMBDA",T],"nm"  ,{ 1000,1800}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["LOSS1_",T],"nm"  ,{0.001,1000}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["SMSR1_",T],"dB"  ,{   10,1000}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["SML1_" ,T],"dB"  ,{   10,1000}]&,X],wmaps],
     PairCorrelations[Map[ExtractColumn[#,StringJoin["SMR1_" ,T],"dB"  ,{   10,1000}]&,X],wmaps]};

  Y = Select[Join@@Transpose[Map[allmaps,{"25","70","85","95"}]],(#!={})&];
  If[Length[Union[Transpose[Y][[1]]]]==1,
     Print["\n    wrote  ",
        Export[StringJoin[ExcelDataPath, Y[[1, 1]], "_AR.csv"],
            Prepend[Map[Drop[#, 1] &, Y],
           {"Parameter", "Unit", "Repetitions", "CollectedValues",
            "Comparisons",
            "SystemAccuracy", "RandomAccuracy(3Sigma)", "Accuracy(3Sigma)", "MaxDifference",
            "SystemPrecision%","RandomPrecision%(3Sigma)","Precision%(3Sigma)","MaxRelDifference%"}]],
          "\n"]];
      Y];



OneTempSMWaferMaps[T_,save_,F_] := Module[{h,i,r,s,u},
  SMWaferMap[save,    ExtractColumn[F, StringJoin["POPT"  ,T], "mW",  {0.001, 100}],{},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["ITH"   ,T], "mA",  {0.001, 200}],{},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["E_F"   ,T], "mW/A",{1, 1000}],   {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["IF"    ,T], "mA",  {0.001,1000}],{},{}];
  i =                 ExtractColumn[F, StringJoin["IF"    ,T], "A",   {0.000001,0.2}];
  SMWaferMap[save,u = ExtractColumn[F, StringJoin["UF1"   ,T], "V",   {0.1, 10}],   {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["UF2"   ,T], "V",   {0.1, 10}],   {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["RS"    ,T], "Ohm", {0.1, 200}],  {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["SSAT"  ,T], "",    {-100, 100}], {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["LAMBDA",T], "nm",  {1200, 1600}],{},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["LOSS1_",T], "nm",  {0.001, 10}], {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["SMSR1_",T], "dB",  {}],          {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["SML1_" ,T], "dB",  {}],          {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["SMR1_" ,T], "dB",  {}],          {},{}];
  SMWaferMap[save,    ExtractColumn[F, StringJoin["KONT"  ,T], "-",   {}],          {},{}];
(*
  SMWaferMap[save,    ExtractColumn[F, StringJoin["CHIP"  ,T], "V",   {}],          {},{}];
*)
  h = Drop[i[[1]], -2];
  s = Intersection[Transpose[i[[2]]][[1]], Transpose[u[[2]]][[1]]];
  i = Sort[Map[(#[[1]] -> #[[2]]) &, i[[2]]]];
  u = Sort[Map[(#[[1]] -> #[[2]]) &, u[[2]]]];
  r = Map[{#, (# /. u)/(# /. i)} &, s];
  i = Sort[Map[(#[[1]] -> #[[2]]) &, r]];
  r = {Join[h, {StringJoin["R1",T], "Ohm"}], r};
  SMWaferMap[save, r, {}, {}];];



StandardSMWaferMaps85[save_, F_] := Module[
      {i25, r25, s25, u25,
       i85, r85, s85, u85,
       h, rd, sd},

      SMWaferMap[save,    ExtractColumn[F, "POPT25"  , "mW",  {0.001, 200}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "POPT85"  , "mW",  {0.001, 200}], {}, {}];
(*      
      SMWaferMap[save,    ExtractTDrift[F, "POPT"    , "mW",  {0.001, 200},"25","85",True], {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "ITH25"   , "mA",  {0.001, 200}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "ITH85"   , "mA",  {0.001, 200}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "ITH"     , "mA",  {0.001, 200},"25","85",False], {}, {}];
      i25 =               ExtractColumn[F, "IF25"    , "A",   {0.000001,0.2}];
      i85 =               ExtractColumn[F, "IF85"    , "A",   {0.000001,0.2}];

      SMWaferMap[save,    ExtractColumn[F, "E_F25"   , "mW/A", {1, 1000}],   {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "E_F85"   , "mW/A", {1, 1000}],   {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "E_F"     , "mW/A", {1, 1000},"25","85",True],   {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "SSAT25"   , "", {-100, 100}],   {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "SSAT85"   , "", {-100, 100}],   {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "SSAT"     , "", {-100, 100},"25","85",True],   {}, {}];

      SMWaferMap[save,u25=ExtractColumn[F, "UF125"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,u85=ExtractColumn[F, "UF185"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "UF1"     , "V",   {0.1, 10},"25","85",False],    {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "UF225"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "UF285"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "UF2"     , "V",   {0.1, 10},"25","85",False],    {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "RS25"    , "Ohm", {0.1, 200}],  {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "RS85"    , "Ohm", {0.1, 200}],  {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "RS"      , "Ohm", {0.1, 200},"25","85",True],  {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "LAMBDA25", "nm",  {1200, 1600}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "LAMBDA85", "nm",  {1200, 1600}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "LAMBDA"  , "nm",  {1200, 1600},"25","85",False], {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "LOSS1_25", "nm",  {0.001, 10}],  {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "LOSS1_85", "nm",  {0.001, 10}],  {}, {}];
(*      
      SMWaferMap[save,    ExtractTDrift[F, "LOSS1_"  , "nm",  {0.001, 10},"25","85",False],  {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "SMSR1_25", "dB",  {}],           {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "SMSR1_85", "dB",  {}],           {}, {}];
(*      
      SMWaferMap[save,    ExtractTDrift[F, "SMSR1_"  , "dB",  {},"25","85",False],           {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "KONT25"  , "-",   {}],           {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "KONT85"  , "-",   {}],           {}, {}];
(*
      SMWaferMap[save,    ExtractColumn[F, "CHIP25"  , "V",   {}],           {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "CHIP85"  , "V",   {}],           {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "IMON25"  , "mA",  {0.001,   5}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "IMON85"  , "mA",  {0.001,  10}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "IMON"    , "mA",  {0.001,  10}, "25","85",True], {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "E_MON25" , "A/A", {0.0001,  1}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "E_MON85" , "A/A", {0.0001,  1}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "E_MON"   , "A/A", {0.0001,  1}, "25","85",True], {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "ID_MON25" , "nA", {0.001,   5}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "ID_MON85" , "nA", {0.001, 100}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "ID_MON"   , "nA", {0.001, 100}, "25","85",True], {}, {}];

      Return[{}];
      h   = Drop[i25[[1]], -2];
      s25 = Intersection[Transpose[i25[[2]]][[1]], Transpose[u25[[2]]][[1]]];
      s85 = Intersection[Transpose[i85[[2]]][[1]], Transpose[u85[[2]]][[1]]];
      sd  = Intersection[s25, s85];
      i25 = Sort[Map[(#[[1]] -> #[[2]]) &, i25[[2]]]];
      u25 = Sort[Map[(#[[1]] -> #[[2]]) &, u25[[2]]]];
      i85 = Sort[Map[(#[[1]] -> #[[2]]) &, i85[[2]]]];
      u85 = Sort[Map[(#[[1]] -> #[[2]]) &, u85[[2]]]];
      r25 = Map[{#, (# /. u25)/(# /. i25)} &, s25];
      r85 = Map[{#, (# /. u85)/(# /. i85)} &, s85];
      i25 = Sort[Map[(#[[1]] -> #[[2]]) &, r25]];
      i85 = Sort[Map[(#[[1]] -> #[[2]]) &, r85]];
      rd  = Map[{#, (# /. i85) / (# /. i25)} &, sd];
      r25 = {Join[h, {"R125", "Ohm"}], r25};
      r85 = {Join[h, {"R185", "Ohm"}], r85};
      rd  = {Join[h, {"§R1" , "ratio"}], rd };
      SMWaferMap[save, r25, {}, {}];
      SMWaferMap[save, r85, {}, {}];
      SMWaferMap[save, rd , {}, {}];];



StandardSMWaferMaps95[save_, F_] := Module[
      {i25, r25, s25, u25,
       i95, r95, s95, u95,
       h, rd, sd},

      SMWaferMap[save,    ExtractColumn[F, "POPT25"  , "mW",  {0.001, 200}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "POPT95"  , "mW",  {0.001, 200}], {}, {}];
(*      
      SMWaferMap[save,    ExtractTDrift[F, "POPT"    , "mW",  {0.001, 200},"25","95",True], {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "ITH25"   , "mA",  {0.001, 200}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "ITH95"   , "mA",  {0.001, 200}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "ITH"     , "mA",  {0.001, 200},"25","95",False], {}, {}];
      i25 =               ExtractColumn[F, "IF25"    , "A",   {0.000001,0.2}];
      i95 =               ExtractColumn[F, "IF95"    , "A",   {0.000001,0.2}];

      SMWaferMap[save,    ExtractColumn[F, "E_F25"   , "mW/A", {1, 1000}],   {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "E_F95"   , "mW/A", {1, 1000}],   {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "E_F"     , "mW/A", {1, 1000},"25","95",True],   {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "SSAT25"   , "", {-100, 100}],   {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "SSAT95"   , "", {-100, 100}],   {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "SSAT"     , "", {-100, 100},"25","95",True],   {}, {}];

      SMWaferMap[save,u25=ExtractColumn[F, "UF125"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,u95=ExtractColumn[F, "UF195"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "UF1"     , "V",   {0.1, 10},"25","95",False],    {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "UF225"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "UF295"   , "V",   {0.1, 10}],    {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "UF2"     , "V",   {0.1, 10},"25","95",False],    {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "RS25"    , "Ohm", {0.1, 200}],  {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "RS95"    , "Ohm", {0.1, 200}],  {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "RS"      , "Ohm", {0.1, 200},"25","95",True],  {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "LAMBDA25", "nm",  {1200, 1600}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "LAMBDA95", "nm",  {1200, 1600}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "LAMBDA"  , "nm",  {1200, 1600},"25","95",False], {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "LOSS1_25", "nm",  {0.001, 10}],  {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "LOSS1_95", "nm",  {0.001, 10}],  {}, {}];
(*      
      SMWaferMap[save,    ExtractTDrift[F, "LOSS1_"  , "nm",  {0.001, 10},"25","95",False],  {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "SMSR1_25", "dB",  {}],           {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "SMSR1_95", "dB",  {}],           {}, {}];
(*      
      SMWaferMap[save,    ExtractTDrift[F, "SMSR1_"  , "dB",  {},"25","95",False],           {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "KONT25"  , "-",   {}],           {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "KONT95"  , "-",   {}],           {}, {}];
(*
      SMWaferMap[save,    ExtractColumn[F, "CHIP25"  , "V",   {}],           {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "CHIP95"  , "V",   {}],           {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "IMON25"  , "mA",  {0.001,   5}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "IMON95"  , "mA",  {0.001,  10}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "IMON"    , "mA",  {0.001,  10}, "25","95",True], {}, {}];
*)
      SMWaferMap[save,    ExtractColumn[F, "E_MON25" , "A/A", {0.0001,  1}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "E_MON95" , "A/A", {0.0001,  1}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "E_MON"   , "A/A", {0.0001,  1}, "25","95",True], {}, {}];

      SMWaferMap[save,    ExtractColumn[F, "ID_MON25" , "nA", {0.001,   5}], {}, {}];
      SMWaferMap[save,    ExtractColumn[F, "ID_MON95" , "nA", {0.001, 100}], {}, {}];
      SMWaferMap[save,    ExtractTDrift[F, "ID_MON"   , "nA", {0.001, 100}, "25","95",True], {}, {}];

      Return[{}];
      h   = Drop[i25[[1]], -2];
      s25 = Intersection[Transpose[i25[[2]]][[1]], Transpose[u25[[2]]][[1]]];
      s95 = Intersection[Transpose[i95[[2]]][[1]], Transpose[u95[[2]]][[1]]];
      sd  = Intersection[s25, s95];
      i25 = Sort[Map[(#[[1]] -> #[[2]]) &, i25[[2]]]];
      u25 = Sort[Map[(#[[1]] -> #[[2]]) &, u25[[2]]]];
      i95 = Sort[Map[(#[[1]] -> #[[2]]) &, i95[[2]]]];
      u95 = Sort[Map[(#[[1]] -> #[[2]]) &, u95[[2]]]];
      r25 = Map[{#, (# /. u25)/(# /. i25)} &, s25];
      r95 = Map[{#, (# /. u95)/(# /. i95)} &, s95];
      i25 = Sort[Map[(#[[1]] -> #[[2]]) &, r25]];
      i95 = Sort[Map[(#[[1]] -> #[[2]]) &, r95]];
      rd  = Map[{#, (# /. i95) / (# /. i25)} &, sd];
      r25 = {Join[h, {"R125", "Ohm"}], r25};
      r95 = {Join[h, {"R195", "Ohm"}], r95};
      rd  = {Join[h, {"§R1" , "ratio"}], rd };
      SMWaferMap[save, r25, {}, {}];
      SMWaferMap[save, r95, {}, {}];
      SMWaferMap[save, rd , {}, {}];];



GoodParts[M_,K_,T1_,T2_] := Module[{g,MyETD},

    MyETD[name_,unit_,rng_,rat_] := Module[{p},
        p = Interval[rng];
        Select[
            ExtractTDrift[M,name,unit,{},T1,T2,rat][[2]],
            IntervalMemberQ[p,#[[2]]]&]];

      g = Intersection@@Map[
            Transpose[
              If[StringTake[#[[1]],3]=="TD_",
                         MyETD[  StringDrop[#[[1]],3],#[[2]],Take[#,{3,4}],#[[5]]]     ,
                 ExtractColumn[M,           #[[1]]   ,#[[2]],Take[#,{3,4}]       ][[2]]]][[1]]&,
            K];
      Print["\n    ",Length[g]," good parts among ",Length[M[[2]]]-2," measured  =  ",
            RealForm[100*Length[g]/(Length[M[[2]]]-2),5,1]," %\n"];
      Map[({SMDiv,1}.#)&,g]];



SelectPartsNMF[path_, outpath_, smw_, P_, ignore_, disguise_] := Module[
      {a, c, disgcol, getgb, getsm, i, igb, ism, n, nbc, S},


      disgcol[s_] := Module[{a},
        a = MyStringPartition[s,{" ",FromCharacterCode[9]}];
        If[StringLength[a[[1]]=StringJoin[a[[1]],"X"]]>8,
           a[[1]] = StringTake[a[[1]],-8]];
        StringDrop[StringJoin@@Map[StringJoin[#," "]&,a],-1]];


      getgb[s_] := Module[{h},
          If[(h = Check[StringTake[s, igb], ""]) == "", Return[0.0]];
          If[Head[h = Check[ToExpression[h], 0.0]] != Integer, Return[0.0]];
          Switch[h,
            1, True,
            0, False,
            _, 0.0]];


      getsm[s_] := Module[{h},
          If[(h = Check[StringTake[s, ism], ""]) == "", Return[Null]];
          If[Head[h = Check[ToExpression[h], 0.0]] != Integer, Return[Null]];
          h];


      a = StringPosition[smw, "_"][[1, 1]];
      a = Map[
          StringJoin[StringTake[smw, a - 1], #, StringDrop[smw, a],"_.nmf"] &,
          {"-", "_", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}];
      n = FileNames[a, {path}];
      S = Length[n];
      If[S == 0,
        Print["    No NMF file  ", a, "  found in  ", path];
        Return[]];
      If[S > 1, Print["    ", S, " NMF files  ", a, "  found in  ", path]];
      n = Sort[Map[{MyDateConv[FileDate[#]], #} &, n]][[-1, 2]];        (*  nimm das juengste!  *)
      Print["    loading  ", n];
      S = ReadList[n, String];
      n = StringDrop[n, StringLength[DirectoryName[n]]];
      If[{StringTake[n, 4], StringTake[n, {6, 7}]} != {S[[9]], S[[10]]},
        Print["\n      INCONSISTENT FILE NAME\n"];
        Return[]];
      n = StringJoin[
            outpath,
            S[[ 9]],
            S[[12]],
            S[[10]],
            S[[11]] = Switch[StringTake[n, {8, 8}],
                             "-", "1",
                             "_", "1",
                             "0", "1",
                             "1", "2",
                             "2", "3",
                             "3", "4",
                             "4", "5",
                             "5", "6",
                             "6", "7",
                             "7", "8",
                             "8", "9",
                             "9", "9",
                               _, "9"],
            ".nmf"];
      a = ToExpression[S[[16]]];
      If[Head[a] != Integer, Return[]];
      c = Map[MyStringPartition[#, {" ", FromCharacterCode[9]}][[1]] &,
              Take[S, {17, a + 16}]];
      igb = Check[Position[c, "GESAMTB" ][[1, 1]], 0];
      ism = Check[Position[c, "SUBMOUNT"][[1, 1]], 0];
      If[ism == 0,
        Print["    No column SUBMOUNT found. Exiting."];
        Return[],
        ism = {11*ism - 10, 11*ism}];
      If[igb == 0,
        igb = Table[True, {i, Length[S] - a - 16}],
        nbc = Select[c,(StringTake[#,Min[StringLength[#],6]]=="GBBACK")&];
        nbc =
          ToString[
            1 + If[nbc == {}, 0,
                Max[Map[ToExpression[StringTake[#,{7,8}]]&,nbc]]]];
        nbc = StringJoin["GBBACK", If[StringLength[nbc] == 1, "0", ""], nbc];
        S[[16 + igb]] = nbc;
        igb = {11*igb - 10, 11*igb};
        igb = Map[getgb, Drop[S, a + 16]]];
      ism = Map[getsm, Drop[S, a + 16]];
      S = Join[
          Take[S, a + 16], {StringJoin["SELECT",StringDrop[nbc,6]],"GESAMTB"},
          Map[(StringJoin @@ #) &,
            Transpose[
              {Drop[S, a + 16],
                Map[StringJoin["          ", ToString[#],"          ", ToString[#]]&,
                  c = Map[
                      Switch[
                          If[(Head[#[[1]]] === Integer) && (Head[#[[2]]] === Symbol),
                            If[ignore, True, #[[2]]] && MemberQ[P, {Quotient[#[[1]], SMDiv], 
                                                                         Mod[#[[1]], SMDiv] }],
                            False],
                          True, 1,
                          False, 0,
                          _, 0] &,
                      Transpose[{ism, igb}]]]}]]];
      S[[16]] = ToString[a += 2];
      If[disguise,
         Scan[(S[[#]]=disgcol[S[[#]]])&,
              Complement[
                Table[i,{i,17,a+14}],
                Complement[
                    Map[If[#=={},Null,#[[1,1]]]&[Position[Take[S,a+16],#]]&,
                        {"ANGLE",
                         "CHICHALD",
                         "CRC",
                         "DK",
                         "LDNR",
                         "SUBMOUNT"}],
                    {Null}]]]];
      Print["    wrote    ", S = Export[n, S, "Lines"]];
      Print["    ", Plus @@ c, " good parts\n    ", a, " data columns\n"];
      S];



CRCEncodeNMF[name_, chg_, kennung_] := Module[
      {a, c, calccrc, f, fn, h, i, icr, ism, S, W, Y, Z},

      calccrc[s_] := Module[{c, h, i, k, t},
          k = If[(h = Check[StringTake[s, ism], ""]) == "",
              -Position[S, s][[1, 1]],
              If[Head[h = Check[ToExpression[h], 0.0]] != Integer,
                -Position[S, s][[1, 1]],
                h]];
          If[(h = Check[StringTake[s, icr], ""]) == "",
            Y = Append[Y, k];
            Return[Null]];
          If[Head[h = Check[ToExpression[h], 0.0]] != Integer,
            Y = Append[Y, k];
            Return[Null]];
          c = StringCRC[t = StringDrop[s, icr]];
          If[chg,
            StringInsert[t,
              StringJoin["      ",
                FromCharacterCode[
                  Table[48, {i, 5 - StringLength[c = ToString[c]]}]],
                c],
              icr[[1]]],
            If[c != h, Y = Append[Y, k]];
            s]];

      Y = {};
      Print["    loading  ", name];
      S = ReadList[name, String];
      a = ToExpression[S[[16]]];
      If[Head[a] != Integer, Return[{0}]];
      fn = StringDrop[name,StringLength[DirectoryName[name]]];
      If[chg,
         S[[ 9]] = StringTake[fn,4    ];
         S[[10]] = StringTake[fn,{6,7}];
         S[[11]] = StringTake[fn,{8,8}];
         S[[12]] = StringTake[fn,{5,5}]];
      h = MyStringPartition[S[[6]], {";"}];
      Z = Join[
          Drop[Drop[Take[S, a + 16], {16, 16}], {6, 6}],
          {S[[16]], ToString[Length[S] - a - 16]}];
      Z = ToString[StringCRC[W=StringJoin@@Z]];
      If[chg,
        S[[6]] = StringJoin[Z,
            StringJoin @@ Map[
                StringJoin[";", #] &,
                If[MemberQ[{41, 42}, kennung],
                  Append[Drop[h, 2], ToString[kennung]],
                  Print["\n      Invalid administrator tag:  ", kennung,"\n"];
                  Drop[h, 1]]]],
        If[Z!=h[[1]],
           Print["      FILE HEADER is corrupted:\n        tag = ",h[[-1]],
                 "    wrong CRC = ",h[[1]]];
           Scan[Print["          ",#[[2]],"  (",#[[1]],")"]&,
                Sort[Map[{ToCharacterCode[#][[1]],#}&,
                         Complement[Union[Characters[W]],
                                          Characters[
           " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"]]]]];
           Print["      correct CRC is  ",Z];
           Y = {0}]];
      If[Not[chg]&&(Y!={}),Return[Y]];
      c = Map[MyStringPartition[#, {" ", FromCharacterCode[9]}][[1]] &,
              Take[S, {17, a + 16}]];
      If[(icr = Check[Position[c, "CRC"][[1, 1]], 0]) == 0,
        Print["    No column CRC found. Exiting."];
        Return[{0}],
        icr = {11*icr - 10, 11*icr}];
      ism = If[(ism = Check[Position[c, "SUBMOUNT"][[1, 1]], 0]) == 0, {},
               {11*ism - 10, 11*ism}];
      Print["    ", Length[c], " columns,  ",
        Length[S] - a - 16, " data lines\n      calculating line CRCs ..."];
      S = Join[
          Take[S, a + 16],
          Select[Map[calccrc, Drop[S, a + 16]], Not[#===Null]&]];
      c = Length[Complement[Y, {0}]];
      If[Not[chg] || (chg && (c > 0)),
        Print["      ", c, " corrupted lines found"]];
      If[Not[chg], Return[Y]];
      f = OpenWrite[StringJoin[MyTempDir,fn]];
      Scan[WriteString[f,#,"\n"]&,S];
      Print["    wrote  ",Close[f]];
      Y];



MyPowerRange[Pavg_, ER_, OMA_, dBLoss_] := Module[{d, P1, P2},
      If[MemberQ[{Integer, Real}, Head[ER]]&&
         MemberQ[{Integer, Real}, Head[OMA]  ],
         Return[{}]];
      d = 10^(0.1*dBLoss);
      If[MemberQ[{Integer, Real},Head[OMA]],
        P1 = d*(Pavg - OMA/2);
        P2 = d*(Pavg + OMA/2),
        P1 = 10^(-0.1*ER);
        P2 = 2*d*Pavg/(1 + P1);
        P1 *= P2];
      {P1, P2}];



CleanUpKL[X_] := Module[{p, u},
      p = Flatten[Position[Transpose[X[[2, 2]]][[2]], N[-1000]]];
      u = Flatten[Position[Transpose[X[[3, 2]]][[2]], N[-0.0001]]];
      p = Union[u, p];
      If[p == {}, Return[X]];
      p = Max[0, Min[p] - 1];
      u = ReplacePart[X, Take[X[[2, 2]], p], {2, 2}];
      u = ReplacePart[u, Take[u[[3, 2]], p], {3, 2}];
      u];



CropKL[Imax_, Vmax_, M_] := Module[{n, P, U},
      P = M[[4]];
      U = M[[5]];
      n = Map[(# < Vmax) &, Transpose[U][[2]]];
      n = Position[n, False];
      n = If[n == {}, Length[U], Max[1, n[[1, 1]] - 1]];
      n = Min[U[[n, 1]], Imax];
      Join[Take[M, 3],
        {Select[P, (#[[1]] <= n) &],
         Select[U, (#[[1]] <= n) &]}]];



PolSwitchKL := ReplacePart[#, Transpose[Transpose[#[[3, 2]]]*{1, -1}], {3, 2}]&;



ExtractKL[name_, data_] := Module[{conv, f, r, T, w},

      conv[x_] := Module[{Y},
          Y = Map[
              MyStringPartition[#, {","}] &,
              ReadList[
                ATF[StringJoin[MyTempDir, w, "@", T, "_", x, "i.csv"]],
                String]];
          Print[
            "    ", ToUpperCase[x],
            ":    ", Length[Y[[1]]] - 1, " curves  ",
            FromCharacterCode[225], "  ", Length[Y] - 1, " points"];
          Y = Transpose[
              Prepend[
                Partition[
                  Map[
                    ToExpression[
                        StringReplace[#,
                          {"e+" -> "*10^",
                            "e-" -> "*10^-",
                            "E+" -> "*10^",
                            "E-" -> "*10^-"}]] &,
                    Join @@ Drop[Y, 1]],
                  Length[Y[[1]]]],
                Y[[1]]]];
          Y = Map[Transpose[{Y[[1]], #}] &, Drop[Y, 1]];
          Y = Map[

              ReplacePart[#, {# + {1, 3}, # + {4, 6}} &[
                    StringPosition[#[[1, 2]], " "][[1, 1]]], {1, 1}] &,
              Y];
          Y = Map[
              ReplacePart[#,
                  ToExpression[
                    {StringTake[#[[1, 2]], #[[1, 1, 1]]],
                      StringTake[#[[1, 2]], #[[1, 1, 2]]]}],
                  {1, 1}] &,
              Y];
          Sort[Y]];

      T =
        StringTake[
          w = StringDrop[name, StringLength[DirectoryName[name]]], {7, 8}];
      w = StringJoin[StringTake[w, 4], "_", StringTake[w, {5, 6}]];
      If[(r =
              FileNames[{f =
                    StringDrop[name,
                      StringLength[
                        DirectoryName[name]]]}, {MyTempDir}]) == {},
        CopyFile[name, f = StringJoin[MyTempDir, f]],
        f = r[[1]]];
      r = Export[StringJoin[MyTempDir, "request.txt"],
          Prepend[If[data === "All", {}, data], {f,""}], "Table"];
      ATF[f];
      Run[f = Export[StringJoin[MyTempDir, "klex.bat"],
            {"@echo off", StringJoin["call ", MyHomeBat],
              StringTake[MyTempDir, 2], StringJoin["cd ", MyTempDir],
              StringJoin["klex2 request.txt ", T],
              If[UCL,"pause","REM"]},
            "Lines"]];
      DeleteFile[f];
      DeleteFile[r];
      ATF[StringJoin[MyTempDir, w, "@", T, "_toc.csv"]];
      If[MemberQ[{{}, "All"}, data],
        r = Transpose[
            Drop[
              Transpose[
                Drop[
                  Import[StringJoin[MyTempDir, w, "@", T, "_toc.csv"]],
                  1]],
              1]];
        Return[If[data === {}, r, ExtractKL[name, r]]]];
      Map[
        {#[[1, 1, 1]],
            {#[[1, 1, 2]], Drop[#[[1]], 1]},
            {#[[2, 1, 2]], Drop[#[[2]], 1]}} &,
        Transpose[{conv["p"], conv["u"]}]]];



LoadAllKL[path_, wafer_, T_, extensions_] := Module[{Y},
      Y = Map[
          StringJoin[
              If[StringTake[path, -1]=="\\", path, StringJoin[path, "\\"]],
              StringReplace[wafer, {"_"->"", "-"->""}],
              ToString[T], ".d", #]&,
          Sort[If[Head[extensions]===List, extensions, {extensions}]]];
      Y = Join@@Map[(CleanUpKL/@TakeKL[ExtractKL[#, "All"], {2, -2}])&, Y];
      Y = Map[(#[[1]]->#)&, Reverse[Y]];
      Y = {Union[Map[#[[1]]&, Y]], Y};
      Sort[Y[[1]]/.Y[[2]]]];



MergeKL[akl_, pos_] := Module[{F, Y},
      F = Transpose[Sort[Map[{StringTake[#, -3], #}&, akl]]][[2]];
      Y = If[(pos==={})||(pos===Null)||(pos==="all"),
          ExtractKL@@@Transpose[{F, Map[ExtractKL[#,  {}]&, F]}],
                                    Map[ExtractKL[#, pos]&, F]  ];
      Y = Map[(#[[1]]->#)&, Reverse[Join@@Y]];
      F = Union[Map[#[[1]]&, Y]];
      F/.Y];



PlotAllKL[X_, lab_] := Module[{B, c, i, GP, GU},
      c = Length[X] - 1;
      c = Transpose[Sort[N[Table[{RandomReal[], i}, {i, 0, c}]/c]]][[2]];
      c =
        Map[(Rule @@ #) &,
          Transpose[{Transpose[X][[1]], Map[Hue[0.75*#] &, c]}]];
      B =
        Reverse[Sort[
            Map[{#[[1]] /. c,
                  StringReplace[#[[2, 1]], {" " -> "   ", "P@" -> ""}]} &,
              X]]];
      B = Graphics[
          {Thickness[0.005],
            {GrayLevel[1], Line[{{0, 1}, {10, 1}}]},
            Table[
              {{B[[i, 1]], Line[{{3, i}, {4.5, i}}]},
                Text[B[[i, 2]], {5, i}, {-1, 0}]},
              {i, Length[B]}]},
          AspectRatio -> Max[0.1, Length[B]/40],
          ImageSize -> 500,
          PlotRange -> {{0, 10}, {0, 1 + Length[B]}},
          LabelStyle -> ReplacePart[MyTS, 9, {-1, 2}]];
      Show[GP=
        Graphics[Map[{#[[1]] /. c, Line[#[[2, 2]]]} &, X],
          Frame -> True,
          FrameLabel -> {"I  (mA)", "P  (mW)"},
          ImageSize -> 800,
          PlotLabel -> StringJoin[
              If[Head[lab] === String, lab, ToString[lab]],
              " :    ", ToString[Length[X]], "  P(I) curves"],
          PlotRange -> All,
          LabelStyle -> MyTS]];
      Show[GU=
        Graphics[Map[{#[[1]] /. c, Line[#[[3, 2]]]} &, X],
          Frame -> True,
          FrameLabel -> {"I  (mA)", "U  (V)"},
          ImageSize -> 800,
          PlotLabel -> StringJoin[
              If[Head[lab] === String, lab, ToString[lab]],
              " :    ", ToString[Length[X]], "  U(I) curves"],
          PlotRange -> All,
          LabelStyle -> MyTS]];
      (*
        Show[B]
        *)
      {GP, GU}];



TakeKL[X_, good_] := Map[
      ReplacePart[
          ReplacePart[#,
            Take[#[[2, 2]], good], {2, 2}],
          Take[#[[3, 2]], good], {3, 2}] &,
      X];



GatherData[M_, cols_] := Module[{A, S},
      A =
        Map[Map[ReplacePart[#, {SMDiv, 1}.#[[1]], 1] &,
              ExtractColumn[M, #[[1]], #[[2]], {}][[2]]] &, cols];
      Scan[Print["    ", #[[1, 1]], " (", #[[1, 2]], "):    ", #[[2]]] &,
        Transpose[{cols, Map[Length, A]}]];
      S = Intersection @@ Map[Transpose[#][[1]] &, A];
      Print["\n        ", Length[S], " data sets\n"];
      Rule @@@
        Transpose[{S,
            Transpose[Map[(S /. #) &, Map[Sort[Rule @@@ #] &, A]]]}]];



Consider[M_, S_] := Module[{A, d, s},
      d = Map[({SMDiv, 1}.#) &, Union[S]];
      s = Position[M[[2, 1]], "SUBMOUNT"][[1, 1]];
      A = Select[Drop[M[[2]], 2], MemberQ[d, #[[s]]] &];
      Print["    ", Length[A], " data lines left"];
      ReplacePart[M, Join[Take[M[[2]], 2], A], 2]];



Discard[M_, S_] := Module[{A, d, s},
      d = Map[({SMDiv, 1}.#) &, Union[S]];
      s = Position[M[[2, 1]], "SUBMOUNT"][[1, 1]];
      A = Select[Drop[M[[2]], 2], Not[MemberQ[d, #[[s]]]] &];
      Print["    ", Length[A], " data lines left"];
      ReplacePart[M, Join[Take[M[[2]], 2], A], 2]];



SelectBad[M_, p_, u_, r_] := Module[{B, i},
      B = Join @@ Map[ExtractColumn[#, p, u, {}][[2]] &, M];
      Print[i = Length[B]];
      If[B != {},
        B = Transpose[B];
        If[(i > 2) && Not[MemberQ[B[[2]], Infinity]],
          Histogram[B[[2]],
            Frame -> True,
            FrameLabel -> {StringJoin[p, "  (", u, ")"], "Count"},
            ImageSize -> 350,
            LabelStyle -> MyTS];
          Print[Quartiles[B[[2]]]]];
        If[r == {}, B = {},
          i = Interval[r];
          B = Select[Transpose[B], Not[IntervalMemberQ[i, #[[2]]]] &];
          If[B != {},
            B = Transpose[B][[1]]]]];
      B];



YStat[S_, i_] := Module[{a, b, j, K, x, y, z},
      K = 20;
      a = Interval[i];
      a = Transpose[Select[S, IntervalMemberQ[a, #[[1]]] &]];
      x = Mean[a[[1]]];
      y = Sort[a[[2]]];
      y = Interpolation[
          Transpose[{y, N[Table[j - 1, {j, Length[y]}]/(Length[y] - 1)]}],
          InterpolationOrder -> 1];
      y = Transpose[
          Map[{#, y[#]} &,
            y[[1, 1, 1]] +
              N[Table[j/K, {j, 0, K}]]*(y[[1, 1, 2]] - y[[1, 1, 1]])]];
      y = {Transpose[{Drop[y[[1]], -1], Drop[y[[1]], 1]}],
                      Drop[y[[2]], 1] - Drop[y[[2]], -1]};
      z = Sort[Transpose[Reverse[y]]];
      z = Select[z, (#[[1]] == z[[-1, 1]]) &];
      z = Plus @@@ (Transpose[z][[2]]);
      z = (Plus @@ z)/(2*Length[z]);
      b = 0.1*(i[[2]] - i[[1]]);
      b = x + {-b, b};
      y[[1]]  = Map[Rectangle @@ Transpose[{b, #}] &, y[[1]]];
      y[[2]] /= Max[y[[2]]];
      y[[2]]  = Map[Hue[0.7, 1 - 0.8*#, 0.25 + 0.75*#] &, y[[2]]];
      y = Transpose[Reverse[y]];
      {x, Mean[a[[2]]], StandardDeviation[a[[2]]], Skewness[a[[2]]], y, z, Length[a[[2]]]}];



Trend[xy_, offset_, polord_, xlab_, ylab_, plab_, path_] := Module[{a, b, c, d, f, G, H, i, j, n, s, x},
      s = Sort[xy];
      n = Length[s];
      If[n<40,Return[]];
      d = Floor[n/30];
      While[(d>2)&&(Round[n/d]<30),d--];
      If[d<2,d=2];
      (*
      If[d>10,d=10];
      *)
      s = Map[Transpose[Take[s, #]]&,
              Sort[Transpose[{1+Drop[#, -1], Drop[#, 1]}]&[Round[n*Range[0, d]/d]]]];

      Clear[TrendAuxDataPoints];
      TrendAuxDataPoints = 0.9544997361036416;
      TrendAuxDataPoints = Map[{MeanCI[#[[1]],ConfidenceLevel->TrendAuxDataPoints],
                                MeanCI[#[[2]],ConfidenceLevel->TrendAuxDataPoints]}&, s];
      TrendAuxDataPoints = Join@@@Transpose[{Map[Total               , TrendAuxDataPoints, {2}]/2,
                                             Map[Differences[#][[1]]&, TrendAuxDataPoints, {2}]/4}];
      s = Map[Drop[#, {3}]&, TrendAuxDataPoints];
      f = Length[s];
      G = First[ErrorListPlot[H=N[s], DisplayFunction -> Identity]];
      G = Flatten[Map[Extract[G, Most/@Position[G, #]]&, {Line, Point}]];
      G = {{AbsolutePointSize[3], CMYKColor[0, 1, 0, 0.3], Point/@xy},
           Join[{CMYKColor[0, 0, 1, 0], AbsolutePointSize[7], AbsoluteThickness[2]}, G]};
      s = Transpose[s];
      f = Take[a + b*x + c*x^2 + i*x^3 + j*x^4, Min[f, Min[4, polord]+1]];
      If[offset===False, f = f/.(a->0)];
      f = Evaluate[
             Normal[
                NonlinearModelFit[
                   Transpose[Take[s, 2]],
                   f,
                   Complement[ExpressionVariables[f], {x}],
                   x,
                   Weights->1/s[[3]]^2]
                   ]/.x->#]&;
      G = Insert[G,
          Plot[f[x], {x, Min[s[[1]]], Max[s[[1]]]},
              DisplayFunction -> Identity,
              PlotRange -> All,
              PlotStyle -> {AbsoluteThickness[3], CMYKColor[0, 0, 1, 0]}][[1]],
          3];
      Show[TrendDataPlot = G = Graphics[G,
        AspectRatio -> 1,
        Axes        -> False,
        Background  -> Black,
        DisplayFunction -> If[DisplayTrendGraph, Print, Identity],
        Frame       -> True,
        FrameLabel  -> {xlab, ylab},
        FrameStyle  -> GrayLevel[0.7],
        GridLines   -> Automatic,
        ImageSize   -> 800,
        PlotLabel   -> StringJoin[plab,"        ",ToString[n],"  parts"],
        PlotRange   -> All,
        LabelStyle  -> Prepend[MyTS, FontColor -> GrayLevel[0.7]]]];
      If[StringQ[path],a=
         FastExport[
            StringJoin[path,
               StringReplace[plab, " " -> ""], " ",
               StringReplace[MyStringPartition[ylab, "("][[1]], " " -> ""], " vs ",
               StringReplace[MyStringPartition[xlab, "("][[1]], " " -> ""], " ",
               ToString[n], "pcs", ".gif"],
            G, "GIF"];
         If[Not[DisplayTrendGraph],Print[a]]];
      {xlab, ylab, plab, n, H, f}];



FocusEvaluation[
      outpath_,
      wafer_,
      PixelSize_,           (* µm *)
      Z1_, Z2_, dZ_,        (* µm *)
      Padj_,                (* mW *)
      submount_,
      images_,
      backgnd_,
      dsp_] := Module[
      {a, a1, a2, A, cr, CL, CropXY, CubeSize, DensColPlot, dim, f, fr, g, G, h,
       H, i, j, k, K, LoadImage, m, M, nx, ny, nz, p, r, s, S, scf, ToVector,
       U, V, w, W, x, y, Y, z, Z},


      CropXY[c_, B_] :=
        {B[[1]],
         Transpose[Take[Transpose[Take[B[[2]], c[[2]]]], c[[1]]]],
         {{c[[1, 1]], c[[2, 1]]},
          {1 - Subtract @@ c[[1]], 1 - Subtract @@ c[[2]]}},
         B[[4]]};


      CubeSize[S_] := Reverse[{Length[S[[1, 1]]], Length[S[[1]]], Length[S]}];


      DensColPlot[R_, lab_,
          ar_, gspac_, ims_,
          xlab_, xrng_,
          ylab_, yrng_,
          zlab_, zrng_] := Module[{cb, G, i, n, rcf, x},

          rcf = Hue[0.73*(1 - #)] &;

          If[CL,
            Export[
                StringJoin[
                    MyTempDir,wafer,"-",ToString[submount],"@",lab,".csv"],R]];
          n  = 200;
          cb = zrng[[1]] + (zrng[[2]] - zrng[[1]])*(n = N[Table[i, {i, 0, n}]/n]);
          cb = Transpose[{Drop[cb, -1], Drop[cb, 1]}];
          cb = Map[Rectangle @@ Transpose[{{0, 1}, #}] &, cb];
          cb = Transpose[{rcf /@ ((Drop[n, 1] + Drop[n, -1])/2), cb}];
          cb = Graphics[cb,
              AspectRatio -> 8,
              Frame       -> True,
              FrameLabel  -> {"", zlab},
              FrameTicks  -> {None, Automatic},
              PlotRange   -> {{-0.1, 1.05}, zrng + 0.01*{1, -1}*Subtract @@ zrng},
              LabelStyle   -> MyTS];
          G = Graphics[
              Raster[R,
                {{xrng[[1]], yrng[[1]]},
                 {xrng[[2]], yrng[[2]]}},
                zrng,
                ColorFunction -> rcf],
              AspectRatio -> ar,
              Frame       -> True,
              FrameLabel  -> {xlab, ylab},
              PlotLabel   -> lab,
              LabelStyle   -> MyTS];
          GraphicsRow[{G, cb},
            Spacings -> gspac,
            ImageSize       -> ims]];


      LoadImage[name_, height_] := Module[{a, b, nx, ny, P, Pmin, U},
          P    = Import[name][[1, 1]];
          nx   = Length[P[[1]]];
          ny   = Length[P];
          Pmin = Min[P];
          Print["    ", name];
          If[dsp,
             Print["    ", nx, " * ", ny, " pixels"];
             Print["    Range:    ", Pmin, " .. ", Max[P]]];
          Pmin += backgnd;
          If[dsp,Print["    Background threshold: ", 0.5+Pmin]];
          U = Sort[Select[Flatten[P], (# > Pmin) &]];
          U = {Pmin, Map[{# - Pmin, Count[U, #]} &, Union[U]]};

(*
Return[{"",{},{{1,480},{1,640}},U}];
*)

          a = Position[Map[(Max[#] > Pmin) &,           P ], True];
          b = Position[Map[(Max[#] > Pmin) &, Transpose[P]], True];
          a = {a[[1, 1]], a[[-1, 1]]};
          b = {b[[1, 1]], b[[-1, 1]]};
          If[dsp,
            Print["    X =       ", b[[1]], " .. ", b[[2]]];
            Print["    Y =       ", a[[1]], " .. ", a[[2]]]];
          {StringJoin[wafer, "-", ToString[submount], " @ ", ToString[Round[height]], " µm"],
           P,
           {b, a},
           U}];


      ToVector[H_] := Module[{i, V},
          V = Table[0, {i, dim}];
          Scan[(V[[#[[1]]]] = #[[2]]) &, H];
          N[V/Sqrt[V.V]]];


      CL  = False;
      scf = 0.001*Padj/(0.0001*PixelSize)^2;
      Z   = Table[Z1 + i*dZ, {i, 0, Round[(Z2 - Z1)/dZ]}];
      If[Length[Z] == Length[images],
         W = LoadImage @@@ Transpose[{images, Z}],
         Return[]];
      cr = Transpose[Map[Flatten[#[[3]]] &, W]];
      Print["    ",
            cr = {{Min[cr[[1]]], Max[cr[[2]]]},
                  {Min[cr[[3]]], Max[cr[[4]]]}}];


      W = Map[CropXY[cr, #] &, W];


      A = Transpose[Map[#[[4]] &, W]];
      If[Length[dim = Union[A[[1]]]] != 1, Return[]];
      A = A[[2]];
      m = Map[Max[Transpose[#][[1]]] &, A];
      If[dsp,
        Show[
          Graphics[
            {Thickness[0.001],
              G = Map[Drop[#, 1] &,
                  Sort[
                    Transpose[
                      {RandomReal[UniformDistribution[0, 1], Length[A]],
                       Hue  /@ (0.7*Table[i, {i, 0, Length[A] - 1}]/(Length[A] - 1)),
                       Line /@ A}]]]}],
          Axes       -> False,
          Frame      -> True,
          FrameLabel -> {"Gray level", "Frequency"},
          GridLines  -> Automatic,
          ImageSize  -> 450,
          PlotRange  -> All,
          LabelStyle  -> MyTS]];
      A = Transpose[Reverse[Sort[Transpose[{m, A}]]]][[2]];
      dim = Max[m];
      H = K = ToVector /@ A;
      If[Union[H] != Sort[H], Return[]];

      U = Take[H, 1];
(*
      U = Drop[H,{2,-2}];
*)
      For[k = Length[U]+1,
        k <= 3,
        k++,
        H = Complement[H, U];
        U = Append[U,
                Sort[
                    Table[{Max[Table[U[[i]].H[[j]], {i, Length[U]}]], H[[j]]},
                                                    {j, Length[H]}]][[1, 2]]]];
      A = Map[A[[Position[K, #][[1, 1]]]] &, U];
      If[dsp,
        Show[
          Graphics[
            {Thickness[0.003],Select[G, MemberQ[A, #[[2, 1]]] &]}],
            Axes       -> False,
            Frame      -> True,
            FrameLabel -> {"Gray level", "Frequency"},
            GridLines  -> Automatic,
            ImageSize  -> 450,
            PlotRange  -> All,
            LabelStyle  -> MyTS]];
      p[g_, a1_, a2_] := a1*g + a2*g^2;
      S = Map[Simplify[(p[#[[1]], a1, a2].#[[2]] - 1)] &, Transpose /@ A];
      Y = FindMinimum[S.S,
          {a1, 0.001},
          {a2, 0.001}];
      S = S /. Y[[2]];
      If[dsp,
        ListLinePlot[S,
          Axes       -> False,
          Frame      -> True,
          GridLines  -> Automatic,
          ImageSize  -> 400,
          PlotStyle  -> {Thickness[0.008], RGBColor[1, 0, 0]},
          PlotRange  -> All,
          LabelStyle  -> MyTS]];
      f[x_] = Expand[scf*p[x, a1, a2] /. Y[[2]]];
      fr    = W[[1, 4, 1]] + {0, Max[m]};

(*
Return[{submount, scf, Y[[1]], fr, f}];
*)

      If[dsp,
        Plot[f[x-fr[[1]]],
          {x, fr[[1]], fr[[2]]},
          Axes       -> False,
          Frame      -> True,
          FrameLabel -> {"Gray level", "Power density    ( W/cm² )"},
          GridLines  -> Automatic,
          ImageSize  -> 400,
          PlotLabel  -> "Calibration",
          PlotStyle  -> {Thickness[0.008], RGBColor[0, 0, 1]},
          PlotRange  -> All,
          LabelStyle  -> MyTS]];
      s  = Evaluate[f[Max[0, # - W[[1, 4, 1]]]]] &;
      W  = Map[Map[s, #[[2]], {2, 2}] &, W];
      nz = Length[W];
      ny = Length[W[[1]]];
      nx = Length[W[[1, 1]]];
      r = {Min[W], Max[W]};
      w = cr = Table[{i, j}, {j, ny}, {i, nx}];
      w = Map[((Plus @@ Join @@ (w*#))/(Plus @@ Join @@ #)) &, W];
      W = Transpose[Reverse[Sort[Transpose[{Reverse /@ w, W}]]]];
      w = W[[1]];
      W = W[[2]];
      M = Reverse[(#[[Quotient[1 + Length[#], 2]]]) &[Position[W, Max[W]]]];
      cr = PixelSize*Map[Sqrt[#.#] &, Map[(# - Drop[M, -1]) &, cr, {2, 2}], {2, 2}];
      w = Map[Transpose[{Z, #}] &, Reverse[Transpose[w]]];
      w = ArcTan[Map[Coefficient[Fit[#, {1, a}, a], a] &, w]]*180/Pi;
      If[dsp,
        Show[
          GraphicsRow[
            {Histogram[
                h = 10^3*Map[Plus @@ Flatten[#] &, W]*(10^-4*PixelSize)^2,
                Axes            -> False,
                DisplayFunction -> Identity,
                Frame           -> True,
                FrameLabel      -> {"Integral power  (mW)", "Frequency"},
                LabelStyle       -> MyTS],
              ListLinePlot[Transpose[{Z, h}],
                Axes            -> False,
                DisplayFunction -> Identity,
                Frame           -> True,
                FrameLabel      -> {"Z  (µm)", "Integral power  (mW)"},
                GridLines       -> Automatic,
                PlotStyle       -> {Thickness[0.01], RGBColor[0, 0, 1]},
                PlotRange       -> {0, 1.1*Max[h]},
                Prolog          -> {Thickness[0.01], RGBColor[0, 1, 0],
                                    Line[{{Z1, Padj}, {Z2, Padj}}]},
                LabelStyle       -> MyTS]},
            DisplayFunction -> $DisplayFunction,
            ImageSize       -> 700]]];
      Clear[A, G, H, K, p, s];
      a1 = DensColPlot[
          Transpose[W, {2, 3, 1}][[x = M[[1]]]],
          StringJoin["X = ", RealForm[x *= PixelSize, 3, 1], " µm"],
          1.618, 0, 500,
          "Y  (µm)", {0, PixelSize*ny},
          "Z  (µm)", {Z1 - dZ/2, Z2 + dZ/2},
          "Power density    ( W/cm² )", r];
      a2 = DensColPlot[
          Transpose[W, {2, 1, 3}][[y = M[[2]]]],
          StringJoin["Y = ", RealForm[y *= PixelSize, 3, 1], " µm"],
          1.618, 0, 500,
          "X  (µm)", {0, PixelSize*nx},
          "Z  (µm)", {Z1 - dZ/2, Z2 + dZ/2},
          "Power density    ( W/cm² )", r];
      a3 = DensColPlot[
          G = W[[z = M[[3]]]],
          g = StringJoin["Z = ", RealForm[z = Z1 + dZ*(z - 1), 1, 0], " µm"],
          Automatic, -0.25, 500,
          "X  (µm)", {0, PixelSize*nx},
          "Y  (µm)", {0, PixelSize*ny},
          "Power density    ( W/cm² )", r];
      p = 0.5;
      s = 0;
      G = Transpose[MyPartition[1, Transpose[{p*Round[Flatten[cr]/p], Flatten[G]}]]];
      G[[2]] = Flatten /@ G[[2]];
      G[[2]] = Plus @@@ G[[2]]/(Length /@ G[[2]]);
      G = Take[Transpose[G],1 + Position[Map[(# > 0) &, G[[2]]], True][[-1, 1]]];
      H = ListLinePlot[G,
          Axes            -> False,
          DisplayFunction -> Identity,
          Frame           -> True,
          FrameLabel      -> {"Radius  (µm)", "Power density  (W/cm²)"},
          GridLines       -> Automatic,
          PlotStyle       -> {Thickness[0.01], RGBColor[0, 0, 1]},
          PlotRange       -> All,
          LabelStyle       -> MyTS];
      G = Transpose[G];
      G[[2]] = Map[(s += #) &, G[[1]]*G[[2]]];
      G[[2]] *= 1/G[[2, -1]];
      G = Transpose[G];
      G[[1]] = {0, {0, 0}};
      G[[-1, 2]] = {1, 0};
      G = Interpolation[G];
      K = Plot[G[a/2], {a, 0, 2*G[[1, 1, 2]]},
          Axes            -> False,
          DisplayFunction -> Identity,
          Frame           -> True,
          FrameLabel      -> {"Core diameter  (µm)", "Coupling  efficiency"},
          GridLines       -> Automatic,
          PlotStyle       -> {Thickness[0.01], RGBColor[1, 0, 0]},
          PlotRange       -> All,
          LabelStyle       -> MyTS];
      A = Map[G, {3.0, 4.5}];
      Clear[G, p];
      p = StringJoin[wafer, "-", ToString[submount]];
      K = GraphicsRow[{H, K},
            Spacings -> 0.1,
            ImageSize       -> 700,
            PlotLabel       -> StringJoin[p, "        ",
                                g, "                                ",
                                "6 µm : ", RealForm[100*A[[1]], 1, 0], "% ,    ",
                                "9 µm : ", RealForm[100*A[[2]], 1, 0], "%"],
            LabelStyle       -> MyTS];
      G = GraphicsRow@@Prepend[
            {Spacings -> 0,
             ImageSize       -> 800,
             PlotLabel       -> StringJoin[p,
                  "          Schiel trnsv.:  ", RealForm[w[[2]], 4, 2], "°",
                  "          Schiel lngtd.:  ", RealForm[w[[1]], 4, 2], "°"],
             LabelStyle       -> MyTS},
            Join[{a1[[1, 1]], a2[[1, 1]]}, a3[[1]]]];
      If[dsp,
        Show[G];
        Show[K]];
      G = Import[g = Export[StringJoin[MyTempDir, "mytmpimage.gif"], G]];
      DeleteFile[g];
      G[[1, 1]] = Transpose[Drop[Drop[Drop[Transpose[G[[1, 1]]], {581, 610}], 40], -85]];
      G[[1, 1]] = Join[Drop[G[[1, 1]], {-25, -15}], Take[G[[1, 1]], 10]];
      G[[2, 2]] = G[[1, 2, 2]] = {Length[G[[1, 1, 1]]], Length[G[[1, 1]]]};
      p = StringJoin[outpath, If[StringTake[outpath, -1] == "\\", "", "\\"], p, "_"];
      Print["    wrote ", Export[StringJoin[p, "FM.gif"], G]];
      Print["    wrote ", Export[StringJoin[p, "CC.gif"], K]];
      {{wafer, submount, Padj}, z, Reverse[w], A, {f, fr}}];



findout[P_] := Module[{i, T},
      SlowConnection = True;
      T = FastGet[
            StringJoin[
              "\\\\Mucsdn02\\DFB_BHLM\\InP-Messtechnik\\BarrenAuswertung\\CompiledData\\Mathematica\\",
              P[[1]], 
              "_index.dat"]];
      SlowConnection = False;
      If[Not[T[[1]]===P[[1]]], Return[{}]];
      T = Sort[T[[2]]];
      T = Join@@@Transpose[{P[[2]], P[[2]]/.T}];
      i = Length[T];
      T = Select[T, (Length[#[[2]]]==5)&];
      i -= Length[T];
      If[i!=0, Print["    ", P[[1]], ":    ", i, "  missing measurements"]];
      Map[
        Flatten[
          Join[{P[[1]], #[[1]],
                Check[
                  If[#[[2, 1]]=={}, "???",
                     StringJoin@@Drop[Flatten[Transpose[{Map["-"&, #[[2, 1]]], #[[2, 1]]}]], 1]],
                  "???"]},
               Map[StringJoin[#[[1]], "_", #[[2]]]&,
                 Transpose[
                   ReplacePart[#,
                         Map[StringReplace[#, "-"->":"]&, #[[2]]],
                         2]&[Transpose[
                       Map[
                         MyStringPartition[#, {"_"}]&,
                         Take[#[[2]], -2]]]]]]]]&, T]];



MergeMB[far_, W_, BD_, veeco_] := Module[{B, hb, hm, i, M, v},
      M = If[far,
             M = FileNames[
                   {StringJoin[W[[1]], "{*}xall.dat"]},
                   {"\\\\Mucsdn02\\DFB_BHLM\\InP-Messtechnik\\BarrenAuswertung\\CompiledData\\Mathematica\\"}];
             M = Sort[M][[-1]];
             Print["    copying & reading\n      ", M];
             Run["copy", M, MyTempDir];
             Get[ATF[StringJoin[MyTempDir, BareName[M]]]],
             M = FileNames[{StringJoin[W[[1]], "{*}xall.dat"]}, {MyTempDir}];
             M = Sort[M][[-1]];
             Print["    reading  ", M];
             Get[M]];
      If[Check[Not[Length[M]===3], True],
        Print["    READ FAILURE."];
        Return[{}]];
      Print["        ", M[[1, 1]]];
      If[Not[M[[1, 1]] === W[[1]]], Return[{}]];
      v = Sort[Map[(({1000, 1}.Take[#, {2, 3}]) -> #[[4]])&, Select[veeco, (#[[1]] == W[[1]]) &]]];
      i = Position[M[[2, 1]], "CHIPOSLD"][[1, 1]];
      hm = ReplacePart[Transpose[Take[M[[2]], 2]], {"EPIWAFER", ""}, i];
      hm = Prepend[hm, {"VeecoRun", ""}];
      M = Transpose[Drop[M[[2]], 2]];
      M = Prepend[M, Map[If[Head[#] === String, #, "???"] &, M[[i]] /. v]];
      i++;
      M = Sort[Map[(#[[i]] -> ReplacePart[#, W[[1]], i]) &, Transpose[M]]];
      i = Position[BD[[2, 1]], "SUBMOUNT"][[1, 1]];
      hb = Transpose[Take[BD[[2]], 2]];
      B = Sort[Map[(#[[i]] -> #) &, Drop[BD[[2]], 2]]];
      B = Transpose[Map[{#[[1]] /. B, #[[2]] /. M} &, W[[2]]]];
      i = Map[Null &, hb];
      B[[1]] = Map[If[Not[Head[#] === List], i, If[Length[#] != Length[i], i, #]]&, B[[1]]];
      i = Map[Null &, hm];
      B[[2]] = Map[If[Not[Head[#] === List], i, If[Length[#] != Length[i], i, #]] &, B[[2]]];
      B = Join @@@ Transpose[B];
      Join[Transpose[Join[hb, hm]], B]];



LoadPMF[fname_] := Module[{h, H, i, K, M, P, PMF, R, T},
      PMF = ReadList[fname, String];
      PMF = Map[StringReplace[#, {" "                 ->"",
                                  FromCharacterCode[9]->""}]&,
                PMF];
      PMF = Select[PMF, (#!="")&];
      PMF = Map[StrgPart[#, {","}]&, PMF];
      PMF = Select[PMF, (StringPosition[#[[1]], "Comment"]=={})&];
      If[Length[Union[Length/@PMF]]!=2, Return[{}]];
      H = Position[PMF, "[END_OF_HEADER]"];
      If[H == {}, Return[{}]];
      H = Take[PMF, i = H[[1, 1]]];
      H = Select[H, (Length[#] == 1) &];
      If[H == {}, Return[{}]];
      H = Transpose[H][[1]];
      h = Flatten[
          Map[Position[H, #] &,
            Select[H, (StringDrop[#, {2, -2}] === "[]") &]]];
      If[h == {}, Return[{}]];
      h = Union[Append[h, Length[H]]];
      h = Transpose[{Drop[h, -1], Transpose[{Drop[h + 1, -1], Drop[h - 1, 1]}]}];
      H = Map[{H[[#[[1]]]], Take[H, #[[2]]]} &, h];
      H = Join @@ Map[
            Outer[
                StringJoin, 
                {StringJoin[StringTake[#[[1]], {2, -2}], ":"]}, 
                #[[2]]][[1]] &, 
            H];
      H = Map[MyStringPartition[#, {"="}] &, H];
      H = Select[H, (Length[#] == 2) &];
      If[H == {}, Return[{}]];
      H = Sort[Rule @@@ H];

      M = Drop[PMF, i];
      P = M[[1]] = M[[1]]/.{"LDNR"   ->"CHIPOSLD",
                            "CHIP_ID"->"CHIPOSLD" };
      i = Position[M[[1]], "SUBMOUNT"];
      If[i == {}, Return[{}]];
      i = i[[1, 1]];
      h = Take[M, 2];
      M = Select[Drop[M, 2], Check[Head[ToExpression[#[[i]]]]===Integer, False]&];
      If[M=={}, Return[{}]];
      M = Join[h, Map[numcnv, M, 2]/.{" "->Null}];
      M = {{StringInsert["WAFER:wafer_ID" /. H, "_", 5], Null, Null}, M, {}};
      
      P = Map[MyStringPartition[#, {"_"}]&, P];
      P = Select[P, (Length[#]===3)&];
      If[P=={}, Return[{}]];
      P = Select[P, Not[MemberQ[{"AC", "DEV", "LINK", "MP", "PD", "T1", "T2", "T3", "TD", "TOSA"}, #[[1]]]]&];
      If[P=={}, Return[{}]];
      R = Transpose[P][[3]];
      P = ToExpression/@Union[Flatten[P]];
      P = Select[P, Not[Head[#]===Integer]&];
      If[P=={}, Return[{}]];
      R = Union[Select[ToExpression/@R, (Head[#]===Integer)&]];
      If[R=={}, Return[{}]];
      
      T = {"SCHEDULE:T1", "SCHEDULE:T2"} /. H;
      
      Print["\n    SM-Wafer:       ", M[[1, 1]]];
      Print["    Positions:      ", Length[M[[2]]] - 2];
      Print["    Readouts:       ", Length[R], "    ", Map[StringJoin[ToString[#], "h"] &, R]];
      Print["    Temperatures:        ",               Map[StringJoin[ToString[#], "°C"]&, T]];
      
      Clear[i];
      K = Map[{StringJoin["READOUT_#", #, ":Time"],
               StringJoin["READOUT_#", #, ":Power_Calibration_at_T1"],
               StringJoin["READOUT_#", #, ":Power_Calibration_at_T2"]}&,
              ToString/@Table[i-1, {i, Length[R]}]]/.H;
      K = Map[ToExpression, K, {2}];
      Print["    Power calibration factors:\n        ", 
            MatrixForm[
              Prepend[K,
                {"Time", 
                 StringJoin[ToString[T[[1]]], "°C"], 
                 StringJoin[ToString[T[[2]]], "°C"]}]], 
            "\n"];
      K = Map[(#[[1]]->Drop[#, 1])&, K];
      K = Map[If[ListQ[#], #, {1, 1}]&, R/.K];
      
      {M, H, R, T, P, K, fname}];



DupRem[M_, Replacements_] := Join[Take[M, 2],
   Union[Drop[M, 2] /. If[ListQ[Replacements],
      If[Union[Head /@ Replacements] === {Rule}, 
       Replacements, {}], {}]]];



Entries[L_, c_] := Module[{h},
   h = Drop[ExtractColumn[L, {c}], 2];
   If[h == {}, Return[]];
   h = Transpose[h][[1]];
   Reverse[Sort[Map[{Count[h, #], #} &, Union[h]]]]];



Clear[ExtractColumn];

ExtractColumn[M_, col_] := Module[{h, p},
   p = Map[Position[M[[1]], #] &, If[ListQ[col], col, {col}]];
   If[MemberQ[p, {}], Return[{}]];
   h = Transpose[M];
   Transpose[h[[Flatten[p]]]]];



SelectRows[M_, col_, sel_] := Module[{p},
   p = Map[Position[M[[1]], #] &, If[ListQ[col], col, {col}]];
   If[MemberQ[p, {}], Return[Take[M, 2]]];
   p = Map[#[[1, 1]] &, p];
   Join[Take[M, 2], Select[Drop[M, 2], sel @@ #[[p]] &]]];



NewColumn[M_, title_, unit_, calc_, col_] := Module[{p},
   p = Map[Position[M[[1]], #] &, If[ListQ[col], col, {col}]];
   If[MemberQ[p, {}], Return[Take[M, 2]]];
   p = Map[#[[1, 1]] &, p];
   Transpose[
    Append[
     Transpose[M],
     Join[{title, unit}, Map[Check[calc @@ #[[p]], Null] &, Drop[M, 2]]]]]];



ShowTable[M_, HeaderLines_, RowHeads_, Sorted_] := Module[{R, S, T},
   R = Null;
   S = M;
   If[RowHeads === True, R = 1,
    If[IntegerQ[RowHeads],
     If[1 <= RowHeads <= Length[S[[1]]],
      R = RowHeads]]];
   If[IntegerQ[R],
    If[R > 1,
     S = Transpose[S];
     S = Prepend[Drop[S, {R}], S[[R]]];
     S = Transpose[S]]];
   T = Drop[S, 2];
   If[MemberQ[{True, 1, -1}, Sorted], T = Sort[T]];
   If[Sorted === -1, T = Reverse[T]];
   If[IntegerQ[R],
    T = Transpose[T];
    R = T[[1]];
    T = Transpose[Drop[T, 1]]];
   TableForm[T,
    TableHeadings -> {
      If[ListQ[R], R, None],
      If[HeaderLines === 0, None,
       Map[Column[#, Center] &,
        Drop[
         Transpose[Take[S, If[HeaderLines === 1, 1, 2]]],
         If[ListQ[R], 1, 0]]]]}]];



ConcatStringList[StringList_, Delim_] := If[
   MemberQ[{{}, Null, ""}, StringList], "",
   StringJoin @@ 
    Drop[Join @@ Transpose[{Map[Delim &, StringList], StringList}], 
     1]];



SplitListString[S_] := If[StringQ[S],
   Select[
    Map[StripChar[#, " "] &,
     MyStringPartition[S, ";"]],
    (# != "") &],
   {}];



ClusterPlot[cl_, hedge_, imsiz_] := Module[{colors},
   colors = Take[
     {RGBColor[0.4, 0.4, 1],
      RGBColor[1, 0, 0],
      Magenta,
      CMYKColor[1, 0, 0, 0.2],
      RGBColor[0, 0.8, 0],
      CMYKColor[0, 0, 1, 0.2],
      GrayLevel[0.4]},
     Length[cl]];
   Show[
    Graphics[
     {{AbsolutePointSize[7], 
       Transpose[{colors, Map[Thread[Point /@ #] &, cl]}]},
      If[hedge,
       {Thickness[0.005], colors[[1]], 
          Line[Append[#, #[[1]]] &[#[[ConvexHull[#]]]]]} &[cl[[1]]],
       {}]},
     AspectRatio ->(* Automatic *) 1,
     Axes -> False,
     Frame -> True,
     GridLines -> Automatic,
     ImageSize -> If[IntegerQ[imsiz], Max[imsiz, 100], MyImageSize],
     PlotRange -> All,
     LabelStyle -> MyTS]]];



ShowOutliers2D[K_, imsize_] := ClusterPlot[
   Map[Flatten, 
    Transpose[Reverse[MyPartition[1, Reverse /@ (List @@@ K)]]][[
     2]], {2}],
   True,
   imsize];



Outliers2D[DataPoints_,
   maxiter_,
   maxfrac_,
   maxgarb_,
   maxclus_,
   dsp_] := Module[{A, c, decom, K, M},
   A = Select[DataPoints, ListQ];
   A = Select[A, (Length[#] === 2) &];
   A = Select[A, (And @@ (NumberQ /@ #)) &];
   If[Length[A] <= 2, Return[{}]];
   decom = True;
   c = 0;
   M = A;
   While[decom, c++;
    K = FindClusters[M,
      DistanceFunction -> Switch[2,
        1, EuclideanDistance,
        2, SquaredEuclideanDistance,
        3, ManhattanDistance,
        4, ChebyshevDistance,
        5, CanberraDistance,
        6, CosineDistance,
        7, CorrelationDistance,
        8, BrayCurtisDistance,
        _, Automatic],
      Method -> {"Agglomerate",
        Linkage -> Switch[5,
          1, "Single",
          2, "Average",
          3, "Complete",
          4, "Weighted",
          5, "Centroid",
          6, "Median",
          7, "Ward",
          _, Automatic],
        "SignificanceTest" -> Switch[1,
          1, "Silhouette",
          2, "Gap"]}];
    {M, K} = Transpose[Sort[Transpose[{Length /@ K, K}]]];
    If[(dsp >= 2) && (Length[K] > 1), ClusterPlot[Reverse[K], False, Null]];
    If[Length[M] > 1,
     If[(Length[M] > maxclus) || (M[[1]]/Total[Drop[M, 1]] >= maxfrac),
      If[dsp >= 2, Print["    merging clusters  ", M]];
      K = {Join @@ K}]];
    decom = (Length[K] > 1) && 
      If[IntegerQ[maxiter], c < maxiter, True];
    If[(dsp >= 3), Print[Length[K], "  ", decom]];
    M = If[Length[K] > 1, Join @@ Drop[K, 1], K[[1]]];
    ];
   K = {M, Complement[A, M]};
   M = Length /@ K;
   If[(M[[2]]/M[[1]]) >= maxgarb,
    If[dsp >= 1, Print["    finally merging clusters  ", M]];
    K = {Join @@ K, {}}];
   If[dsp >= 1,
    ClusterPlot[K, False, Null];
    Print["    ", c, " partitioning steps"]];
   K];



ImgDatToPixPos[imgdat_] := Module[{i, j, nx, ny, X},
   nx = Length[imgdat[[1]]];
   ny = Length[imgdat];
   X = Transpose[
     {Join@@imgdat,
      Join@@Table[{i, 1 + ny - j},
        {j, 1, ny},
        {i, 1, nx}]}];
   X = Transpose[MyPartition[1, X]];
   X[[2]] = Join@@@X[[2]];
   {Transpose[X], {nx, ny}}];



PixPosToImgDat[pixpos_, imgdim_] := Module[{a, X},
   X = Transpose[pixpos];
   X[[1]] = If[Depth[X[[1]]]==2, {X[[1]]}, Transpose[X[[1]]]];
   X = Map[Transpose[{#, X[[2]]}]&, X[[1]]];
   a = 1 + imgdim[[2]];
   X = Join@@@Map[(Rule@@@Transpose[
          {Map[{a - #[[2]], #[[1]]}&, #[[2]]],
           ConstantArray[#[[1]], Length[#[[2]]]]}])&,
      X, {2}];
   X = Transpose[Join@@@Map[SparseArray[#, Reverse[imgdim]]&, X]];
   Partition[X, imgdim[[1]]]];
