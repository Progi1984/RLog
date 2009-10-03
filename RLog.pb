Import "C:\Program Files\PureBasic\Compilers\ObjectManager.lib"
  Object_GetOrAllocateID  (Objects, Object.l) As "_PB_Object_GetOrAllocateID@8"
  Object_GetObject        (Objects, Object.l) As "_PB_Object_GetObject@8"
  Object_IsObject         (Objects, Object.l) As "_PB_Object_IsObject@8"
  Object_EnumerateAll     (Objects, ObjectEnumerateAllCallback, *VoidData) As "_PB_Object_EnumerateAll@12"
  Object_EnumerateStart   (Objects) As "_PB_Object_EnumerateStart@4"
  Object_EnumerateNext    (Objects, *object.Long) As "_PB_Object_EnumerateNext@8"
  Object_EnumerateAbort   (Objects) As "_PB_Object_EnumerateAbort@4"
  Object_FreeID           (Objects, Object.l) As "_PB_Object_FreeID@8"
  Object_Init             (StructureSize.l, IncrementStep.l, ObjectFreeFunction) As "_PB_Object_Init@12"
  Object_GetThreadMemory  (MemoryID.l) As "_PB_Object_GetThreadMemory@4"
  Object_InitThreadMemory (Size.l, InitFunction, EndFunction) As "_PB_Object_InitThreadMemory@12"
EndImport


  Declare RLogFree(ID.l)

  Procedure.l RLog_WriteLineLog(*RObject.S_RLog, FileID.l, *Item.S_RLog_Log)
    If *RObject
      Protected Content.s
      With *RObject
        FilterOk = #True
        If \Filter_Activate_Level = #True
         If \Filter_Operator_Level = #RLog_Operator_Equal
            If *Item\Level =  \Filter_Content_Level  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Level = #RLog_Operator_NotEqual
            If *Item\Level <> \Filter_Content_Level  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Level = #RLog_Operator_Inferior
            If *Item\Level <  \Filter_Content_Level  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Level = #RLog_Operator_InferiorOrEqual
            If *Item\Level <= \Filter_Content_Level  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Level = #RLog_Operator_Superior
            If *Item\Level >  \Filter_Content_Level  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Level = #RLog_Operator_SuperiorOrEqual
            If *Item\Level >= \Filter_Content_Level  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          EndIf
        EndIf
        If \Filter_Activate_Date = #True And FilterOk <> #False
          If \Filter_Operator_Date = #RLog_Operator_Equal
            If *Item\Date =  \Filter_Content_Date  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Date = #RLog_Operator_NotEqual
            If *Item\Date <> \Filter_Content_Date  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Date = #RLog_Operator_Inferior
            If *Item\Date <  \Filter_Content_Date  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Date = #RLog_Operator_InferiorOrEqual
            If *Item\Date <= \Filter_Content_Date  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Date = #RLog_Operator_Superior
            If *Item\Date >  \Filter_Content_Date  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Date = #RLog_Operator_SuperiorOrEqual
            If *Item\Date >= \Filter_Content_Date  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          EndIf
        EndIf
        If \Filter_Activate_Category = #True And FilterOk <> #False
          If \Filter_Operator_Category = #RLog_Operator_Equal
            If *Item\Category =  \Filter_Content_Category  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          ElseIf \Filter_Operator_Category = #RLog_Operator_NotEqual
            If *Item\Category <> \Filter_Content_Category  : FilterOk = #True  : Else  : FilterOk = #False : EndIf
          EndIf
        EndIf
        
        If FilterOk = #True
          Content = \Default_Formatter
          Content = ReplaceString(Content, "%yyyy",     Str(Year(*Item\Date)))
          Content = ReplaceString(Content, "%mm",       Str(Month(*Item\Date)))
          Content = ReplaceString(Content, "%dd",       Str(Day(*Item\Date)))
          Content = ReplaceString(Content, "%hh",       Str(Month(*Item\Date)))
          Content = ReplaceString(Content, "%ii",       Str(Minute(*Item\Date)))
          Content = ReplaceString(Content, "%ss",       Str(Second(*Item\Date)))
          Content = ReplaceString(Content, "%cat",      *Item\Category)
          Content = ReplaceString(Content, "%level",    Str(*Item\Level))
          Content = ReplaceString(Content, "%content",  *Item\Content)
          ; Tools
          Content = ReplaceString(Content, "%%",  "%")
          Content = ReplaceString(Content, "%n",  Chr(10))
          Content = ReplaceString(Content, "%r",  Chr(13))
          Content = ReplaceString(Content, "%t",  Chr(9))
          Content = ReplaceString(Content, "%v",  Chr(11))
          Content = ReplaceString(Content, "%f",  Chr(12))
          WriteStringN(FileID, Content)
        EndIf
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure


  ProcedureDLL RLog_Init()
    Global RLogObjects 
    RLogObjects = RLOG_INITIALIZE(@RLogFree())
    
    Global NewList LL_RLog_Logs.S_RLog_Log()
  EndProcedure
  ProcedureDLL RLog_Create(ID.l)
    Protected *RObject.S_RLog = RLOG_NEW(ID)
    With *RObject
      \ID               = *RObject
      \Default_Level    = #RLog_Level_Debug
      \Default_Category = "Main"
      \Default_Formatter= "[%yyyy.%mm.%dd %hh:%ii:%ss] (%cat) - %level - %content"
      \OutputFile       = GetCurrentDirectory()+"RLog_Debug.txt"
      \OutputFile_Append= #True
    EndWith
    
    ProcedureReturn *RObject
  EndProcedure
  ProcedureDLL RLog_Is(ID.l)
    ProcedureReturn RLOG_ISID(ID)
  EndProcedure
  ProcedureDLL RLogFree(ID.l)
    RLOG_FREEID(ID)
    ProcedureReturn #True
  EndProcedure

  ProcedureDLL.l RLog_AddLog(Id.l, Content.s, Category.s = "", Level.l = -1)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        LastElement(LL_RLog_Logs())
        AddElement(LL_RLog_Logs())
        LL_RLog_Logs()\ID_Log     = Id
        If Level = -1
          LL_RLog_Logs()\Level    = \Default_Level
        Else
          LL_RLog_Logs()\Level    = Level
        EndIf
        LL_RLog_Logs()\Date       = Date()
        LL_RLog_Logs()\Content    = Content
        If Category = ""
          LL_RLog_Logs()\Category = \Default_Category
        Else
          LL_RLog_Logs()\Category = Category
        EndIf
        If \OutputFile_Append = #True
          FileID = OpenFile(#PB_Any, \OutputFile)
          If FileID
            FileSeek(FileID, Lof(FileID))
            RLog_WriteLineLog(*RObject, FileID, @LL_RLog_Logs())
            CloseFile(FileID)
          EndIf
        EndIf
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  ProcedureDLL.l RLog_ResetLog(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        ForEach LL_RLog_Logs()
          If LL_RLog_Logs()\ID_Log = Id
            DeleteElement(LL_RLog_Logs())
          EndIf
        Next
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  
  ProcedureDLL.l RLog_SetDefaultLevel(Id.l, Level.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        \Default_Level = Level
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  ProcedureDLL.l RLog_GetDefaultLevel(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        ProcedureReturn \Default_Level
      EndWith
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  
  ProcedureDLL.l RLog_SetDefaultCategory(Id.l, Category.s)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        \Default_Category = Category 
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  ProcedureDLL.s RLog_GetDefaultCategory(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        ProcedureReturn \Default_Category 
      EndWith
    Else
      ProcedureReturn ""
    EndIf
  EndProcedure

  ProcedureDLL.l RLog_SetOutputFile(Id.l, Filename.s)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        \OutputFile =  Filename
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  ProcedureDLL.s RLog_GetOutputFile(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        ProcedureReturn \OutputFile
      EndWith
    Else
      ProcedureReturn ""
    EndIf
  EndProcedure

  ProcedureDLL.l RLog_SetMethod(Id.l, Append.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        If Append >= #True
          \OutputFile_Append = #True
        Else
          \OutputFile_Append = #False
        EndIf
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  ProcedureDLL.l RLog_GetMethod(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        ProcedureReturn \OutputFile_Append
      EndWith
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure

  ProcedureDLL.l RLog_SetFormatter(Id.l, Formatter.s)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        \Default_Formatter = Formatter
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  ProcedureDLL.s RLog_GetFormatter(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        ProcedureReturn \Default_Formatter 
      EndWith
    Else
      ProcedureReturn ""
    EndIf
  EndProcedure

  ProcedureDLL.l RLog_Save(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        FileID = OpenFile(#PB_Any, \OutputFile)
        If FileID
          ForEach LL_RLog_Logs()
            If LL_RLog_Logs()\ID_Log = Id
              RLog_WriteLineLog(*RObject, FileID, @LL_RLog_Logs())
            EndIf
          Next
          CloseFile(FileID)
          ProcedureReturn #True
        Else
          ProcedureReturn #False
        EndIf
      EndWith
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure

  ProcedureDLL.l RLog_AddFilter(Id.l, Type.l, Operator.l, Content.s)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        Select Type
          Case #RLog_Filter_Level
            \Filter_Activate_Level    = #True
            \Filter_Operator_Level    = Operator
            \Filter_Content_Level     = Val(Content)
          Case #RLog_Filter_Date
            \Filter_Activate_Date     = #True
            \Filter_Operator_Date     = Operator
            \Filter_Content_Date      = Val(Content)
          Case #RLog_Filter_Category
            \Filter_Activate_Category = #True
            \Filter_Operator_Category = Operator
            \Filter_Content_Category  = Content
        EndSelect
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure
  ProcedureDLL.l RLog_ResetFilter(Id.l)
    Protected *RObject.S_RLog = RLOG_ID(Id)
    If *RObject
      With *RObject
        \Filter_Activate_Level    = #False
        \Filter_Operator_Level    = 0
        \Filter_Content_Level     = 0
        \Filter_Activate_Level    = #False
        \Filter_Operator_Date     = 0
        \Filter_Content_Date      = 0
        \Filter_Activate_Level    = #False
        \Filter_Operator_Category = 0
        \Filter_Content_Category  = ""
      EndWith
      ProcedureReturn #True
    Else
      ProcedureReturn #False
    EndIf
  EndProcedure


;   ProcedureDLL.l RLog_(Id.l)
;     Protected *RObject.S_RLog = RLOG_ID(Id)
;     If *RObject
;       With *RObject
;         Debug 0
;       EndWith
;       ProcedureReturn #True
;     Else
;       ProcedureReturn #False
;     EndIf
;   EndProcedure
; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 115
; Folding = AAAAAAAAAAAAAA9