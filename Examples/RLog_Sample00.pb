; XIncludeFile "RLog.pb"
; 
; RLog_Init()

Debug "==================== #1 : Simple Logging"
RLog_Create(1)

Debug "Default Level :"+Str(RLog_GetDefaultLevel(1))
RLog_SetDefaultLevel(1, #RLog_Level_Info)
Debug "New Level :"+Str(RLog_GetDefaultLevel(1))
Debug " "
Debug "Default Category :"+RLog_GetDefaultCategory(1)
RLog_SetDefaultCategory(1, "RLog")
Debug "New Category :"+RLog_GetDefaultCategory(1)
Debug " "
Debug "Default OutputFile :"+RLog_GetOutputFile(1)
RLog_SetOutputFile(1, GetCurrentDirectory()+"Samples\SampleLog_00.txt")
Debug "New OutputFile :"+RLog_GetOutputFile(1)
Debug " "
Debug "Default AppendMethod :"+Str(RLog_GetMethod(1))
RLog_SetMethod(1, #False)
Debug "New AppendMethod :"+Str(RLog_GetMethod(1))
Debug " "
Debug "Default Formatter :"+RLog_GetFormatter(1)
RLog_SetFormatter(1, "[%cat] [%level] (%yyyy.%mm.%dd %hh:%ii:%ss) : %content")
Debug "New Formatter :"+RLog_GetFormatter(1)

RLog_AddLog(1, "Content Log 1", "", -1)
RLog_AddLog(1, "Content Log 2", "SecondCat", -1)
RLog_AddLog(1, "Content Log 3", "SecondCat", #RLog_Level_Error)

RLog_Save(1)

Debug "==================== #2 : Simple Logging with Append"
Debug "Default AppendMethod :"+Str(RLog_GetMethod(1))
RLog_SetMethod(1, #True)
Debug "New AppendMethod :"+Str(RLog_GetMethod(1))
Debug " "
Debug "Default OutputFile :"+RLog_GetOutputFile(1)
RLog_SetOutputFile(1, GetCurrentDirectory()+"Samples\SampleLog_01.txt")
Debug "New OutputFile :"+RLog_GetOutputFile(1)

RLog_AddLog(1, "Content Log 4", "", -1)
RLog_AddLog(1, "Content Log 5", "SecondCat", -1)
RLog_AddLog(1, "Content Log 6", "SecondCat", #RLog_Level_Error)

Debug "==================== #3 : Simple Logging with Filtering"
Debug "Default AppendMethod :"+Str(RLog_GetMethod(1))
RLog_SetMethod(1, #False)
Debug "New AppendMethod :"+Str(RLog_GetMethod(1))

RLog_AddLog(1, "Content Log 7", "", -1)
RLog_AddLog(1, "Content Log 8", "SecondCat",#RLog_Level_Notice)
RLog_AddLog(1, "Content Log 9", "SecondCat", -1)
RLog_AddLog(1, "Content Log 10", "", #RLog_Level_Notice)
RLog_AddLog(1, "Content Log 11", "SecondCat", #RLog_Level_Error)
RLog_AddLog(1, "Content Log 12", "ThirdCat", #RLog_Level_Notice)

RLog_AddFilter(1, #RLog_Filter_Level, #RLog_Operator_Equal, Str(#RLog_Level_Notice))
RLog_SetOutputFile(1, GetCurrentDirectory()+"Samples\SampleLog_02.txt")
RLog_Save(1)
RLog_ResetFilter(1)

RLog_AddFilter(1, #RLog_Filter_Level, #RLog_Operator_NotEqual, Str(#RLog_Level_Notice))
RLog_SetOutputFile(1, GetCurrentDirectory()+"Samples\SampleLog_03.txt")
RLog_Save(1)
RLog_ResetFilter(1)

RLog_AddFilter(1, #RLog_Filter_Category, #RLog_Operator_NotEqual, "ThirdCat")
RLog_SetOutputFile(1, GetCurrentDirectory()+"Samples\SampleLog_04.txt")
RLog_Save(1)
RLog_ResetFilter(1)

RLog_AddFilter(1, #RLog_Filter_Date, #RLog_Operator_InferiorOrEqual, Str(Date(Year(Date()),Month(Date()),Day(Date())+1,0,0,0)))
RLog_SetOutputFile(1, GetCurrentDirectory()+"Samples\SampleLog_05.txt")
RLog_Save(1)
RLog_ResetFilter(1)

RLogFree(1)

; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 73
; FirstLine = 38
; Folding = -