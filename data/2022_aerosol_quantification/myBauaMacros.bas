Attribute VB_Name = "myMacros"
Sub unmark()
'
' unmark Makro
'
'
    Selection.Shading.Texture = wdTextureNone
    Selection.Shading.ForegroundPatternColor = wdColorAutomatic
    Selection.Shading.BackgroundPatternColor = wdColorAutomatic
End Sub

Sub spezielleseinfuegen()
'
' spzeilleseinfuegen Makro
'
    Selection.PasteSpecial link:=True, DataType:=wdPasteText, Placement:= _
        wdInLine, DisplayAsIcon:=False
End Sub

Sub insertIncludePictureAndHyperlinkQuantificationOfHumanAerosolEmission()
'PFADE anpassen!!!


' insertandlink Makro
'
Dim link As String
Dim pathToFigureNames As String
'link = InputBox("URL zum Bildverzeichnis")
'pathToFigureNames = InputBox("Pfad zu den Bildbezeichnungen/-nummern")

 '  Documents.Open FileName:=pathToFigureNames, ConfirmConversions:= _
        False, ReadOnly:=False, AddToRecentFiles:=False, PasswordDocument:="", _
        PasswordTemplate:="", Revert:=False, WritePasswordDocument:="", _
        WritePasswordTemplate:="", Format:=wdOpenFormatAuto, XMLTransform:=""

    If Selection.PageSetup.Orientation = wdOrientPortrait Then
        Selection.PageSetup.Orientation = wdOrientLandscape
    Else
        Selection.PageSetup.Orientation = wdOrientPortrait
    End If

    Selection.WholeStory
    Selection.ConvertToTable Separator:=wdSeparateByParagraphs, NumColumns:=1, AutoFitBehavior:=wdAutoFitFixed
  
    Selection.Find.ClearFormatting
    Selection.Find.Replacement.ClearFormatting
    With Selection.Find
        .Text = " "
        .Replacement.Text = ""
        .Forward = True
        .Wrap = wdFindAsk
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
   
    ActiveDocument.Tables(1).Select
    
    Selection.InsertColumnsRight
    Selection.InsertColumnsRight
    Selection.Tables(1).AutoFitBehavior (wdAutoFitContent)
    
    
    x = Selection.Rows.Count
    Selection.Collapse
    
    For i = 1 To x
    ActiveDocument.Tables(1).Cell(i, 1).Select
    CharCount = Len(Selection)
    Selection.MoveLeft Unit:=wdCharacter, Count:=1
    Selection.MoveRight Unit:=wdCharacter, Count:=CharCount - 2, Extend:=wdExtend
    nameid = Selection
    
    ActiveDocument.Tables(1).Cell(i, 2).Select
    Selection.MoveLeft
       
    Selection.Fields.Add Range:=Selection.Range, Type:=wdFieldEmpty, Text:= _
        "INCLUDEPICTURE  ""https://raw.githubusercontent.com/Carl-Firle/Quantification-of-Human-Aerosol-Emission/main/figures/"" & nameid & ""%20_%20150%20dpi.png"" \d " _
        , PreserveFormatting:=True
    Selection.MoveLeft Unit:=wdCharacter, Count:=1, Extend:=wdExtend
    ActiveDocument.Hyperlinks.Add Anchor:=Selection.Range, Address:= _
        "https://raw.githubusercontent.com/Carl-Firle/Quantification-of-Human-Aerosol-Emission/main/figures/" & nameid & ".svg" _
        , SubAddress:=""
    
    
    ActiveDocument.Tables(1).Cell(i, 3).Select
    Selection.MoveLeft
     Selection.Fields.Add Range:=Selection.Range, Type:=wdFieldEmpty, Text:= _
        "INCLUDEPICTURE  ""D:\\Daten\\b1464\\Desktop\\Ausgabe\\" & nameid & " _ 72 dpi.png"" \d " _
        , PreserveFormatting:=True

    Next
    
       ChangeFileOpenDirectory "D:\Daten\b1464\Desktop\Ausgabe\"
    ActiveDocument.SaveAs2 FileName:="##2 link included figures in word.docx", _
        FileFormat:=wdFormatXMLDocument, LockComments:=False, Password:="", _
        AddToRecentFiles:=True, WritePassword:="", ReadOnlyRecommended:=False, _
        EmbedTrueTypeFonts:=False, SaveNativePictureFormat:=False, SaveFormsData _
        :=False, SaveAsAOCELetter:=False, CompatibilityMode:=15
        
    
End Sub

Sub insertEquationsQuantificationOfHumanAerosolEmission()
'
' insertandlink Makro
'

Dim pathToFigureNames As String

'pathToFigureNames = InputBox("Pfad zu den Bildbezeichnungen/-nummern")

'   Documents.Open FileName:="D:\Daten\b1464\Downloads\##2 equation IDs.rtf", ConfirmConversions:= _
        False, ReadOnly:=False, AddToRecentFiles:=False, PasswordDocument:="", _
        PasswordTemplate:="", Revert:=False, WritePasswordDocument:="", _
        WritePasswordTemplate:="", Format:=wdOpenFormatAuto, XMLTransform:=""

    If Selection.PageSetup.Orientation = wdOrientPortrait Then
        Selection.PageSetup.Orientation = wdOrientLandscape
    Else
        Selection.PageSetup.Orientation = wdOrientPortrait
    End If

    Selection.WholeStory
    Selection.ConvertToTable Separator:=wdSeparateByParagraphs, NumColumns:=1, AutoFitBehavior:=wdAutoFitFixed
  
    Selection.HomeKey Unit:=wdStory
    Selection.Delete Unit:=wdCharacter, Count:=1
   
    ActiveDocument.Tables(1).Select
    
    Selection.InsertColumnsRight
    Selection.Tables(1).AutoFitBehavior (wdAutoFitContent)
    
    
    x = Selection.Rows.Count
    Selection.Collapse
    
    ActiveDocument.Tables(1).Cell(1, 1).Select
     CharCount = Len(Selection)
    Selection.MoveLeft Unit:=wdCharacter, Count:=1
    Selection.MoveRight Unit:=wdCharacter, Count:=CharCount - 2, Extend:=wdExtend
    eqPath = Selection
    
       
    ActiveDocument.SaveAs2 FileName:=eqPath & "\##2 link included equations in word.docx", _
        FileFormat:=wdFormatXMLDocument, LockComments:=False, Password:="", _
        AddToRecentFiles:=True, WritePassword:="", ReadOnlyRecommended:=False, _
        EmbedTrueTypeFonts:=False, SaveNativePictureFormat:=False, SaveFormsData _
        :=False, SaveAsAOCELetter:=False, CompatibilityMode:=15
    
    For i = 2 To x
    ActiveDocument.Tables(1).Cell(i, 1).Select
    CharCount = Len(Selection)
    Selection.MoveLeft Unit:=wdCharacter, Count:=1
    Selection.MoveRight Unit:=wdCharacter, Count:=CharCount - 2, Extend:=wdExtend
    nameid = Selection
    
    ChangeFileOpenDirectory eqPath
    Documents.Open FileName:=nameid & ".txt", ConfirmConversions:=False, _
        ReadOnly:=False, AddToRecentFiles:=False, PasswordDocument:="", _
        PasswordTemplate:="", Revert:=False, WritePasswordDocument:="", _
        WritePasswordTemplate:="", Format:=wdOpenFormatAuto, XMLTransform:="", _
        Encoding:=1252
    Selection.WholeStory
    Selection.Cut
    Selection.PasteAndFormat (wdFormatPlainText)

    ActiveDocument.SaveAs2 FileName:=nameid & "converted .docx", FileFormat:= _
        wdFormatXMLDocument, LockComments:=False, Password:="", AddToRecentFiles _
        :=True, WritePassword:="", ReadOnlyRecommended:=False, EmbedTrueTypeFonts _
        :=False, SaveNativePictureFormat:=False, SaveFormsData:=False, _
        SaveAsAOCELetter:=False, CompatibilityMode:=15
    ActiveWindow.Close
    
    
    ActiveDocument.Tables(1).Cell(i, 2).Select
    Selection.MoveLeft
        
        
    Selection.Fields.Add Range:=Selection.Range, Type:=wdFieldEmpty, Text:= _
        "LINK  AcroExch.acrobatsecuritysettings.1 ""D:\\Daten\\b1464\\Desktop\\Ausgabe\\equations\\" & nameid & ".docx"" \a \r " _
        , PreserveFormatting:=True
    
      ' Selection.Fields.Add Range:=Selection.Range, Type:=wdFieldEmpty, Text:= _
        "LINK  Word.Document.12 " & eqPath & nameid & ".docx"" \a \r " _
        , PreserveFormatting:=False
        
    Next
    
     ActiveDocument.Save
        
    
End Sub

Sub openrft()
    ChangeFileOpenDirectory "D:\Daten\b1464\Desktop\Ausgabe\equations\"
    Application.Move Left:=55, Top:=115
    Documents.Open FileName:="equation 001.txt", ConfirmConversions:=False, _
        ReadOnly:=False, AddToRecentFiles:=False, PasswordDocument:="", _
        PasswordTemplate:="", Revert:=False, WritePasswordDocument:="", _
        WritePasswordTemplate:="", Format:=wdOpenFormatAuto, XMLTransform:="", _
        Encoding:=1252
    Selection.WholeStory
    Selection.Cut
    Selection.PasteAndFormat (wdFormatPlainText)
    ActiveDocument.SaveAs2 FileName:="equation 001.docx", FileFormat:= _
        wdFormatXMLDocument, LockComments:=False, Password:="", AddToRecentFiles _
        :=True, WritePassword:="", ReadOnlyRecommended:=False, EmbedTrueTypeFonts _
        :=False, SaveNativePictureFormat:=False, SaveFormsData:=False, _
        SaveAsAOCELetter:=False, CompatibilityMode:=15
    ActiveWindow.Close

End Sub



Sub replaceForTablesOfQuantificationOfHumanAerosolEmission()
'
' replace Makro
'
'
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
    With Selection.Find
        .Text = "sub[500 ml]"
        .Replacement.Text = "500 ml"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
        With Selection.Find
        .Text = "sub[1000 ml]"
        .Replacement.Text = "1000 ml"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
    With Selection.Find
        .Text = "sub[2000 ml]"
        .Replacement.Text = "2000 ml"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
        With Selection.Find
        .Text = "sub[3000 ml]"
        .Replacement.Text = "3000 ml"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
        With Selection.Find
        .Text = "sub[maximum]"
        .Replacement.Text = "maximum"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
     With Selection.Find
        .Text = "sub[0.5 s]"
        .Replacement.Text = "0.5 s"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
         With Selection.Find
        .Text = "sub[1 s]"
        .Replacement.Text = "1 s"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
        With Selection.Find
        .Text = "sub[2 s]"
        .Replacement.Text = "2 s"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    With Selection.Find.Replacement.Font
        .Superscript = False
        .Subscript = True
    End With
    With Selection.Find
        .Text = "sub[3 s]"
        .Replacement.Text = "3 s"
        .Forward = True
        .Wrap = wdFindAsk
        .Format = True
        .MatchCase = False
        .MatchWholeWord = False
        .MatchWildcards = False
        .MatchSoundsLike = False
        .MatchAllWordForms = False
    End With
    Selection.Find.Execute replace:=wdReplaceAll
    
    
    Selection.WholeStory
    Selection.ConvertToTable Separator:=wdSeparateByTabs, NumColumns:=3, _
        NumRows:=34, AutoFitBehavior:=wdAutoFitFixed
    With Selection.Tables(1)
        .Style = "Tabellenraster"
        .ApplyStyleHeadingRows = True
        .ApplyStyleLastRow = False
        .ApplyStyleFirstColumn = True
        .ApplyStyleLastColumn = False
    End With
    
End Sub






