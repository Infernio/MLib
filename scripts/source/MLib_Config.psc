ScriptName MLib_Config Extends SKI_ConfigBase
{Defines an MCM consisting of several distinct pages, each of them with a unique script. See MLib_Page.}

; PROPERTIES
MLib_Page[] Property PageScripts Auto
{The pages that will be used to construct this MCM. Fill this instead of Pages, as that property will be overwritten at runtime!}
Int         Property Version Auto
{The version of this MCM.}

; VARIABLES
; The previous version of this MCM script that was installed.
Int oldVersion

; === REGULAR EVENTS === ;

Event OnInit()
    ; Initialize the 'old version' to the current version
    oldVersion = Version
    parent.OnInit()
EndEvent

; === SKYUI EVENTS === ;

Event OnConfigInit()
    Pages = Utility.CreateStringArray(PageScripts.Length)
    Debug.Notification(PageScripts.Length)
    Debug.Notification(Pages.Length)
    Int i = 0
    While(i < PageScripts.Length)
        Pages[i] = PageScripts[i].GetTitle()
        PageScripts[i]._InitPage(self)
        i += 1
    EndWhile
EndEvent

Event OnPageReset(String page)
    GetPageScript(page)._ResetPage()
EndEvent

Event OnOptionSelect(Int option)
    GetPageScript(CurrentPage)._SelectOption(option)
EndEvent

Event OnOptionHighlight(Int option)
    GetPageScript(CurrentPage)._HighlightOption(option)
EndEvent

Event OnVersionUpdate(Int newVersion)
    If(newVersion == oldVersion)
        ; shush, SkyUI
        return
    EndIf
    Debug.Trace("[" + ModName + "] Updating MCM script from " + oldVersion + " to " + newVersion)

    Int i = 0
    While(i < PageScripts.Length)
        PageScripts[i].OnVersionUpdate(oldVersion, newVersion)
        i += 1
    EndWhile

    ; Update the old version
    oldVersion = newVersion
EndEvent

Event OnConfigOpen()
    Int i = 0
    While(i < PageScripts.Length)
        PageScripts[i].OnConfigOpen()
        i += 1
    EndWhile
EndEvent

Event OnConfigClose()
    Int i = 0
    While(i < PageScripts.Length)
        PageScripts[i].OnConfigClose()
        i += 1
    EndWhile
EndEvent

; === SKYUI FUNCTIONS === ;

Int Function GetVersion()
    return Version
EndFunction

; === UTILITY & IntERNAL FUNCTIONS === ;

MLib_Page Function GetPageScript(String page)
    {Finds the page script for the page with the specified name.}
    Int i = 0
    While(i < PageScripts.Length)
        If(page == Pages[i])
            return PageScripts[i]
        EndIf
        i += 1
    EndWhile

    ; Return the first page if we can't find it
    return PageScripts[0]
EndFunction
