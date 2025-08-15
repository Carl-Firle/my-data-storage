myExportFunctionList = {myAroundString, myBAUAColors, myCMYKColors, 
     myExportF, myExportFPNG, myExportFSVG, myFlatten, myFontSize, 
     myFontStandard, myFrameStyle, myFrameTickStyle, myLabelStyle, 
     myLegendAppearance, myPackageInputPrint, myPlotColors, myPlotStyle, 
     myReplaceList, myStringJoin, myStringSplit, myStyle, mySubJoin, myT, 
     myTake, myTickStyle, myTranspose}
 
myAroundString[l_List /; Dimensions[l][[2]] == 2] := 
    Module[{}, (StringJoin[ToString[#1[[1]]]~~" \[PlusMinus] "~~
         ToString[#1[[-1]]]] & ) /@ l]
 
myBAUAColors[a_Integer:5] := Module[{bauaMainColors, bauaHighlightColors, 
      bauaBlueColors, bauaAllColors, bauaDesignColors, bauaCMYKColors}, 
     {bauaMainColors -> {RGBColor["#1A70B8"], RGBColor["#636362"], 
         RGBColor["#F4F3EC"], RGBColor["#E3E5DB"], RGBColor["#ABD18F"]}, 
       bauaHighlightColors -> {RGBColor["#EC6617"], RGBColor["#75BEEA"], 
         RGBColor["#ABD18F"], RGBColor["#F1B300"]}, bauaBlueColors -> 
        {{RGBColor["#114e81"], RGBColor["#015c93"], RGBColor["#1770b8"], 
          RGBColor["#74bdea"], RGBColor["#a6d1f1"], RGBColor["#cfe5f8"]}}, 
       bauaAllColors -> {RGBColor["#1A70B8"], RGBColor["#636362"], 
         RGBColor["#F4F3EC"], RGBColor["#E3E5DB"], RGBColor["#ABD18F"], 
         RGBColor["#75BEEA"], RGBColor["#EC6617"], RGBColor["#F1B300"], 
         RGBColor["#ABD18F"], RGBColor["#114e81"], RGBColor["#015c93"], 
         RGBColor["#a6d1f1"], RGBColor["#cfe5f8"]}, bauaDesignColors -> 
        {RGBColor[0.4588235294117647, 0.7450980392156863, 
          0.9176470588235294], RGBColor[0.9254901960784314, 0.4, 
          0.09019607843137255], RGBColor[0.6705882352941176, 
          0.8196078431372549, 0.5607843137254902], 
         RGBColor[0.9450980392156862, 0.7019607843137254, 0.], 
         RGBColor[0.10196078431372549, 0.4392156862745098, 
          0.7215686274509804], RGBColor[0.38823529411764707, 
          0.38823529411764707, 0.3843137254901961], 
         RGBColor[0.8901960784313725, 0.8980392156862745, 
          0.8588235294117647], RGBColor[0.8117647058823529, 
          0.8980392156862745, 0.9725490196078431], 
         RGBColor[0.06666666666666667, 0.3058823529411765, 
          0.5058823529411764]}, bauaCMYKColors -> 
        {CMYKColor[0.85, 0.5, 0, 0], CMYKColor[0.85, 0.5, 0, 0, 0.7], 
         CMYKColor[0.85, 0.5, 0, 0, 0.4], CMYKColor[0.85, 0.45, 0, 0.3], 
         CMYKColor[0.85, 0.5, 0, 0.4], CMYKColor[0.85, 0.45, 0, 0.3, 0.7], 
         CMYKColor[0.85, 0.45, 0, 0.3, 0.5], CMYKColor[0.85, 0.45, 0, 0.3, 
          0.3], CMYKColor[0., 0., 0, 0.75], CMYKColor[0., 0., 0.05, 0.06], 
         CMYKColor[0.08, 0.03, 0.12, 0.07], CMYKColor[0.62, 0.27, 0.92, 0.7], 
         CMYKColor[0.55, 0.1, 0, 0], CMYKColor[0., 0.75, 1, 0], 
         CMYKColor[0., 0.3, 1, 0.05], CMYKColor[0.4, 0., 0.55, 0]}}[[a,2]]]
 
myCMYKColors[a_Integer:1] := Module[{}, 
     {{CMYKColor[{0, 0, 1, 0}], CMYKColor[{9/10, 1/5, 1/2, 0}], 
        CMYKColor[{0, 3/5, 1, 0}], CMYKColor[{1, 11/20, 0, 0}], 
        CMYKColor[{0, 9/10, 1, 0}], CMYKColor[0, 0.09, 1, 0.03], 
        CMYKColor[{9/20, 0, 1/5, 0}], CMYKColor[{2/5, 9/10, 1, 1/2}], 
        CMYKColor[{9/10, 2/5, 0, 0}], CMYKColor[{1/10, 1/10, 9/10, 0}], 
        CMYKColor[{7/20, 3/10, 1/5, 1/5}], CMYKColor[{7/10, 0, 19/20, 0}], 
        CMYKColor[{0, 1/5, 2/5, 1/10}], CMYKColor[{0, 11/20, 1/4, 0}], 
        CMYKColor[{1, 9/10, 0, 1/2}], CMYKColor[{0, 3/10, 1, 0}], 
        CMYKColor[{1/5, 1/10, 1/5, 2/5}], CMYKColor[{1/10, 1, 1, 1/5}], 
        CMYKColor[{3/5, 9/10, 0, 0}], CMYKColor[{0, 1/20, 3/20, 1/20}], 
        CMYKColor[{4/5, 1/10, 4/5, 2/5}], CMYKColor[{0, 9/10, 9/10, 1/5}], 
        CMYKColor[{1, 2/5, 0, 0}], CMYKColor[{0, 3/5, 1/10, 0}], 
        CMYKColor[{0, 1/5, 1/5, 19/20}], CMYKColor[{0, 9/20, 1, 0}], 
        CMYKColor[{4/5, 9/10, 0, 0}], CMYKColor[{0, 1/5, 1/2, 1/5}], 
        CMYKColor[{1/5, 1, 1, 1/10}], CMYKColor[{3/10, 0, 9/10, 2/5}], 
        CMYKColor[{99/100, 13/25, 1/25, 0}], CMYKColor[{0, 7/10, 9/10, 0}], 
        CMYKColor[{0, 1, 0, 0}], CMYKColor[{1/2, 9/10, 0, 1/20}]}, 
       {"Leuchtgelb" -> CMYKColor[{0, 0, 1, 0}], "Zitronengelb" -> 
         CMYKColor[{1/10, 1/10, 9/10, 0}], "Orange" -> 
         CMYKColor[{0, 11/20, 1, 0}], "Hellrosa" -> 
         CMYKColor[{1/20, 2/5, 1/5, 0}], "Altrosa" -> 
         CMYKColor[{0, 3/5, 1/10, 0}], "Feuerrot" -> 
         CMYKColor[{0, 1, 1, 1/5}], "Signalrot" -> 
         CMYKColor[{1/5, 1, 1, 1/10}], "Korallenrot" -> 
         CMYKColor[{0, 9/10, 9/10, 1/5}], "Leuchtrot" -> 
         CMYKColor[{0, 9/10, 1, 0}], "Reines Rot" -> 
         CMYKColor[{0, 1, 9/10, 0}], "Weinrot" -> 
         CMYKColor[{7/20, 1, 13/20, 0}], "Pink" -> CMYKColor[{0, 1, 0, 0}], 
        "Lila" -> CMYKColor[{1/2, 3/5, 0, 0}], "Violett" -> 
         CMYKColor[{3/5, 9/10, 0, 1/10}], "Azurblau" -> 
         CMYKColor[{99/100, 13/25, 1/25, 0}], "Himmelblau" -> 
         CMYKColor[{9/10, 2/5, 0, 0}], "Reines Blau" -> 
         CMYKColor[{1, 7/10, 0, 0}], "Nachtblau" -> 
         CMYKColor[{1, 9/10, 0, 1/2}], "Pastellt\[UDoubleDot]rkis" -> 
         CMYKColor[{3/5, 1/10, 1/2, 0}], "Mintt\[UDoubleDot]rkis" -> 
         CMYKColor[{9/10, 1/5, 1/2, 0}], "T\[UDoubleDot]rkis" -> 
         CMYKColor[{9/10, 1/10, 2/5, 1/10}], 
        "Leuchtgr\[UDoubleDot]n/Gelbgr\[UDoubleDot]n" -> 
         CMYKColor[{7/10, 0, 19/20, 0}], "Gr\[UDoubleDot]n" -> 
         CMYKColor[{9/10, 0, 4/5, 0}], "Grasgr\[UDoubleDot]n" -> 
         CMYKColor[{9/10, 1/5, 1, 1/4}], "Maigr\[UDoubleDot]n" -> 
         CMYKColor[{4/5, 1/5, 1, 1/10}], "Rotbraun" -> 
         CMYKColor[{2/5, 9/10, 1, 1/2}], "Kastanienbraun" -> 
         CMYKColor[{0, 3/5, 3/5, 7/10}], "Schokobraun" -> 
         CMYKColor[{2/5, 9/10, 1, 1/2}], "Cremewei\[SZ]" -> 
         CMYKColor[{0, 1/20, 3/20, 1/20}], "Beige" -> 
         CMYKColor[{0, 1/5, 2/5, 1/10}], "Silbergrau" -> 
         CMYKColor[{1/10, 0, 0, 2/5}], "Steingrau" -> 
         CMYKColor[{1/5, 1/10, 1/5, 2/5}], "Tiefschwarz" -> 
         CMYKColor[{2/5, 1/5, 1/5, 1}]}, 
       {"Leuchtgelb" -> {CMYKColor[{0, 0, 1, 0}]}, "Zitronengelb" -> 
         {CMYKColor[{1/10, 1/10, 9/10, 0}]}, "Orange" -> 
         {CMYKColor[{0, 3/10, 1, 0}], CMYKColor[{0, 9/20, 1, 0}], 
          CMYKColor[{0, 1/2, 1, 0}], CMYKColor[{0, 11/20, 1, 0}], 
          CMYKColor[{0, 3/5, 1, 0}], CMYKColor[{0, 13/20, 1, 0}], 
          CMYKColor[{0, 7/10, 9/10, 0}]}, "Hellrosa" -> 
         {CMYKColor[{1/20, 2/5, 1/5, 0}], CMYKColor[{0, 1/2, 1/5, 1/10}]}, 
        "Altrosa" -> {CMYKColor[{0, 11/20, 1/4, 0}], 
          CMYKColor[{0, 3/5, 1/10, 0}], CMYKColor[{0, 7/10, 3/10, 1/10}], 
          CMYKColor[{0, 13/20, 2/5, 1/10}]}, "Feuerrot" -> 
         {CMYKColor[{0, 1, 1, 1/5}], CMYKColor[{1/10, 1, 1, 1/5}]}, 
        "Signalrot" -> {CMYKColor[{1/5, 1, 1, 1/10}], 
          CMYKColor[{1/5, 1, 9/10, 1/10}]}, "Korallenrot" -> 
         {CMYKColor[{0, 9/10, 9/10, 1/5}], CMYKColor[{0, 9/10, 9/10, 3/10}]}, 
        "Leuchtrot" -> {CMYKColor[{0, 9/10, 1, 0}], CMYKColor[{0, 1, 1, 0}]}, 
        "Reines Rot" -> {CMYKColor[{0, 1, 9/10, 0}], 
          CMYKColor[{0, 1, 7/10, 0}]}, "Weinrot" -> 
         {CMYKColor[{1/5, 1, 4/5, 2/5}], CMYKColor[{2/5, 1, 3/5, 2/5}], 
          CMYKColor[{7/20, 1, 13/20, 0}], CMYKColor[{3/5, 1, 4/5, 0}]}, 
        "Pink" -> {CMYKColor[{0, 1, 0, 0}]}, "Lila" -> 
         {CMYKColor[{1/2, 3/5, 0, 0}], CMYKColor[{3/5, 7/10, 1/20, 1/10}]}, 
        "Violett" -> {CMYKColor[{1/2, 9/10, 0, 1/20}], 
          CMYKColor[{3/5, 9/10, 0, 0}], CMYKColor[{3/5, 9/10, 0, 1/10}], 
          CMYKColor[{4/5, 9/10, 0, 0}], CMYKColor[{3/5, 9/10, 0, 0}], 
          CMYKColor[{9/10, 1, 0, 0}]}, "Azurblau" -> 
         {CMYKColor[{9/10, 3/10, 1/10, 2/5}], CMYKColor[{9/10, 2/5, 0, 
            3/10}], CMYKColor[{99/100, 13/25, 1/25, 0}]}, 
        "Himmelblau" -> {CMYKColor[{9/10, 2/5, 0, 0}], 
          CMYKColor[{9/10, 1/2, 0, 0}], CMYKColor[{1, 3/10, 0, 1/10}], 
          CMYKColor[{1, 2/5, 0, 0}]}, "Reines Blau" -> 
         {CMYKColor[{1, 2/5, 0, 0}], CMYKColor[{1, 11/20, 0, 0}], 
          CMYKColor[{1, 7/10, 0, 0}], CMYKColor[{1, 4/5, 0, 0}], 
          CMYKColor[{19/20, 3/5, 0, 1/5}], CMYKColor[{1, 2/5, 0, 2/5}]}, 
        "Nachtblau" -> {CMYKColor[{1, 9/10, 0, 1/2}], 
          CMYKColor[{1, 1, 2/5, 2/5}]}, "Pastellt\[UDoubleDot]rkis" -> 
         {CMYKColor[{9/20, 0, 1/5, 0}], CMYKColor[{3/5, 1/10, 1/2, 0}], 
          CMYKColor[{9/20, 0, 1/5, 1/5}]}, "Mintt\[UDoubleDot]rkis" -> 
         {CMYKColor[{4/5, 1/5, 1/2, 0}], CMYKColor[{7/10, 3/20, 1/2, 1/5}], 
          CMYKColor[{9/10, 1/5, 1/2, 0}]}, "T\[UDoubleDot]rkis" -> 
         {CMYKColor[{4/5, 1/10, 7/20, 1/5}], CMYKColor[{9/10, 1/10, 2/5, 
            1/10}]}, "Leuchtgr\[UDoubleDot]n/Gelbgr\[UDoubleDot]n" -> 
         {CMYKColor[{7/10, 0, 19/20, 0}], CMYKColor[{3/5, 0, 19/20, 0}], 
          CMYKColor[{7/10, 0, 9/10, 0}]}, "Gr\[UDoubleDot]n" -> 
         {CMYKColor[{13/20, 0, 4/5, 0}], CMYKColor[{9/10, 0, 4/5, 0}], 
          CMYKColor[{17/20, 0, 1, 0}], CMYKColor[{17/20, 0, 1, 1/10}]}, 
        "Grasgr\[UDoubleDot]n" -> {CMYKColor[{3/5, 0, 9/10, 1/10}], 
          CMYKColor[{3/10, 0, 9/10, 2/5}], CMYKColor[{21/25, 0, 1, 0}], 
          CMYKColor[{9/10, 1/5, 1, 1/4}], CMYKColor[{7/10, 1/10, 4/5, 2/5}], 
          CMYKColor[{4/5, 1/10, 4/5, 2/5}]}, "Maigr\[UDoubleDot]n" -> 
         {CMYKColor[{4/5, 1/5, 1, 1/10}]}, "Rotbraun" -> 
         {CMYKColor[{2/5, 9/10, 1, 1/2}], CMYKColor[{1/20, 1, 1, 4/5}]}, 
        "Kastanienbraun" -> {CMYKColor[{0, 3/5, 3/5, 7/10}], 
          CMYKColor[{1/2, 1, 1, 1/2}], CMYKColor[{0, 9/10, 1, 4/5}]}, 
        "Schokobraun" -> {CMYKColor[{2/5, 9/10, 1, 1/2}], 
          CMYKColor[{0, 3/5, 9/10, 4/5}], CMYKColor[{2/5, 7/10, 3/5, 4/5}], 
          CMYKColor[{0, 1/5, 1/5, 19/20}], CMYKColor[{3/5, 4/5, 4/5, 4/5}]}, 
        "Cremewei\[SZ]" -> {CMYKColor[{0, 1/20, 3/20, 1/20}]}, 
        "Beige" -> {CMYKColor[{0, 1/5, 2/5, 1/10}], 
          CMYKColor[{0, 1/5, 1/2, 1/5}]}, "Silbergrau" -> 
         {CMYKColor[{1/10, 0, 0, 2/5}]}, "Steingrau" -> 
         {CMYKColor[{1/5, 1/10, 1/5, 2/5}], CMYKColor[{7/20, 3/10, 1/5, 
            1/5}]}, "Tiefschwarz" -> {CMYKColor[{1, 2/5, 2/5, 9/10}], 
          CMYKColor[{2/5, 1/5, 1/5, 1}], CMYKColor[{3/10, 0, 0, 1}], 
          CMYKColor[{0, 1/2, 1/5, 1}]}}}[[a]]]
 
myExportF[l_List] := Module[{r, g, name}, 
     ((r = 600; g = #1[[1]]; name = #1[[2]]; 
        Table[Export[exPath~~name~~" "~~ToString[r]~~" dpi CMYK"~~i, 
          ColorConvert[Rasterize[g, ImageResolution -> r], "CMYK"]], 
         {i, {".eps", ".png"}}]; r = #1[[3]]; 
        Table[Export[exPath~~name~~" "~~ToString[r]~~" dpi"~~i, 
          Rasterize[g, ImageResolution -> r]], {i, {".png"}}]; 
        (Table[Export[exPath~~name~~i, g], {i, {".svg"}}] & ) /@ #1) & ) /@ l]
 
myExportFPNG[l_List] := Module[{r, g, name}, 
     ((g = #1[[1]]; name = #1[[2]]; r = #1[[3]]; 
        Table[Export[exPath~~name~~" "~~ToString[r]~~" dpi"~~i, 
          Rasterize[g, ImageResolution -> r]], {i, {".png"}}]) & ) /@ l]
 
myExportFSVG[l_List] := Module[{r, g, name}, 
     ((g = #1[[1]]; name = #1[[2]]; (Table[Export[exPath~~name~~i, g], 
           {i, {".svg"}}] & ) /@ #1) & ) /@ l]
 
myFlatten[l_List, level_Integer] := Module[{}, Map[Flatten[#1] & , l, 
      {level}]]
 
myFrameStyle[fontsize_Integer:myFontSize, fontfamily_String:myFontStandard, 
     color_:GrayLevel[0]] := Module[{}, FrameStyle -> 
      Directive[FontSize -> fontsize, FontFamily -> fontfamily, color]]
 
myFrameTickStyle[fontsize_Integer:myFontSize, fontfamily_String:
      myFontStandard, color_:GrayLevel[0]] := 
    Module[{}, FrameTicksStyle -> Directive[FontSize -> fontsize, 
       FontFamily -> fontfamily, color]]
 
myLabelStyle[fontsize_Integer:myFontSize, fontfamily_String:myFontStandard, 
     color_:GrayLevel[0]] := Module[{}, LabelStyle -> 
      Directive[FontSize -> fontsize, FontFamily -> fontfamily, color]]
 
myLegendAppearance[markersize_Integer:myFontSize, 
     fontfamily_String:myFontStandard, color_:GrayLevel[0]] := 
    Module[{}, LegendAppearance -> {LegendMarkerSize -> markersize, 
       FontFamily -> fontfamily, color}]
 
myPackageInputPrint[] := Module[{l}, 
     l = ToExpression /@ (Select[Names["Global`*"], StringContainsQ[
           "my"~~__]] /. {"myExportFunctionList" -> Nothing, 
          "myFontSize" -> Nothing, "myFontStandard" -> Nothing, 
          "myColors" -> Nothing, "myColorForGradient" -> Nothing, 
          "myPlotColors" -> Nothing}); TableForm[Definition /@ l]]
 
myPlotStyle[opacity_:1] := Module[{}, 
     (PlotStyle -> Directive[Opacity[opacity], #1] & ) /@ myPlotColors]
 
myReplaceList[lTarget_List, fReplace_] := 
    Module[{}, (#1 -> fReplace & ) /@ lTarget]
 
myStringJoin[l_List, deli_String:"", start_Integer:2, end_Integer:-2, 
     step_Integer:2] := Module[{}, StringJoin[Riffle[ToString /@ l, deli, 
       {start, end, step}]]]
 
myStringSplit[s_String, deli_List] := Module[{i, out, j}, 
     i = 1; out = StringSplit[s, deli[[i]]]; For[j = 1, j < Length[deli], 
       j++, i++; out = Map[StringSplit[#1, deli[[i]]] & , out, {i - 1}]]; out]
 
myStyle[s_, fontsize_Integer:myFontSize, fontfamily_String:myFontStandard, 
     color_:GrayLevel[0]] := Module[{}, Style[ToString[s], 
      FontSize -> fontsize, FontFamily -> fontfamily, color]]
 
mySubJoin[lTarget_List, lInsert_List, pos_Integer:1] := 
    Module[{}, (Insert[lTarget[[#1[[2]]]], #1[[1]], pos] & ) /@ lInsert]
 
myT[l1_List, l2_List] := Module[{}, Transpose[{l1, l2}]]
 
myTake[lData_List, lSort_List] := Module[{outList, dimensionQ}, 
     If[Length[Dimensions[lData]] > 1, dimensionQ = True, 
       dimensionQ = False]; outList = If[dimensionQ === True, 
        (If[Head[#1] === Span, lData[[All,#1]], {lData[[All,#1]]}] & ) /@ 
         lSort, (If[Head[#1] === Span, lData[[#1]], {lData[[#1]]}] & ) /@ 
         lSort]; outList = (If[Length[#1] > 1, Transpose[#1], #1] & ) /@ 
        outList; outList = Transpose[Flatten[outList, 1]]]
 
myTickStyle[fontsize_Integer:myFontSize, fontfamily_String:myFontStandard, 
     color_:GrayLevel[0]] := Module[{}, TicksStyle -> 
      Directive[FontSize -> fontsize, FontFamily -> fontfamily, color]]
 
myTranspose[lLong_List, lShort_List] := 
    Module[{}, Transpose[{lLong, Table[lShort, Length[lLong]]}]]
