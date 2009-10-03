
;{ Structures
  Structure S_RLog
    ID.l
    Default_Level.l
    Default_Category.s
    Default_Formatter.s
    OutputFile.s
    OutputFile_Append.l
    Filter_Activate_Level.l
    Filter_Operator_Level.l
    Filter_Content_Level.l
    Filter_Activate_Date.l
    Filter_Operator_Date.l
    Filter_Content_Date.l
    Filter_Activate_Category.l
    Filter_Operator_Category .l
    Filter_Content_Category.s
  EndStructure
  Structure S_RLog_Log
    ID_Log.l
    Level.l
    Date.l
    Content.s
    Category.s
  EndStructure
;}
;{ Enumerations
  Enumeration 
    #RLog_Level_Debug
    #RLog_Level_Info
    #RLog_Level_Notice
    #RLog_Level_Warn
    #RLog_Level_Error
    #RLog_Level_Critical
    #RLog_Level_Alert
    #RLog_Level_Emergency
  EndEnumeration
  Enumeration 1
    #RLog_Filter_Level
    #RLog_Filter_Date
    #RLog_Filter_Category
  EndEnumeration
  Enumeration 1
    #RLog_Operator_Inferior
    #RLog_Operator_InferiorOrEqual
    #RLog_Operator_Superior
    #RLog_Operator_SuperiorOrEqual
    #RLog_Operator_Equal
    #RLog_Operator_NotEqual
  EndEnumeration
;}
;{ Macros
  Macro RLOG_ID(object)
    Object_GetObject(RLogObjects, object)
  EndMacro
  Macro RLOG_ISID(object)
    Object_IsObject(RLogObjects, object) 
  EndMacro
  Macro RLOG_NEW(object)
    Object_GetOrAllocateID(RLogObjects, object)
  EndMacro
  Macro RLOG_FREEID(object)
    If object <> #PB_Any And RLog_Is(object) = #True
      Object_FreeID(RLogObjects, object)
    EndIf
  EndMacro
  Macro RLOG_INITIALIZE(hCloseFunction)
    Object_Init(SizeOf(S_RLog), 1, hCloseFunction)
  EndMacro
;}

; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 71
; Folding = Ai-