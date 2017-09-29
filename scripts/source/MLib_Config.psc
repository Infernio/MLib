ScriptName MLib_Config Extends SKI_ConfigBase
{Defines an MCM consisting of several distinct pages, each of them with a unique script. See MLib_Page.}

; PROPERTIES
MLib_Page[] Property PageScripts Auto
{The pages that will be used to construct this MCM. Fill this instead of Pages, as that property will be overwritten at runtime!}
int         Property Version Auto
{The version of this MCM.}

; VARIABLES
; The previous version of this MCM script that was installed.
int oldVersion

; === REGULAR EVENTS === ;

Event OnInit()
    ; Initialize the 'old version' to the current version
    oldVersion = Version
    parent.OnInit()
EndEvent

; === SKYUI EVENTS === ;

Event OnConfigInit()
    Pages = Utility.CreateStringArray(PageScripts.length)
    int i = 0
    While(i < PageScripts.length)
        Pages[i] = PageScripts[i].GetTitle()
        PageScripts[i]._InitPage(self)
        i += 1
    EndWhile
EndEvent

Event OnPageReset(string page)
    Debug.MessageBox("OnPageReset(string) called")
    GetPageScript(page)._ResetPage()
EndEvent

Event OnOptionSelect(int option)
    GetPageScript(CurrentPage)._SelectOption(option)
EndEvent

Event OnOptionHighlight(int option)
    GetPageScript(CurrentPage)._HighlightOption(option)
EndEvent

Event OnVersionUpdate(int newVersion)
    If(newVersion == oldVersion)
        ; shush, SkyUI
        return
    EndIf
    Debug.Trace("[" + ModName + "] Updating MCM script from " + oldVersion + " to " + newVersion)

    int i = 0
    While(i < PageScripts.length)
        PageScripts[i].OnVersionUpdate(oldVersion, newVersion)
        i += 1
    EndWhile

    ; Update the old version
    oldVersion = newVersion
EndEvent

Event OnConfigOpen()
    int i = 0
    While(i < PageScripts.length)
        PageScripts[i].OnConfigOpen()
        i += 1
    EndWhile
EndEvent

Event OnConfigClose()
    int i = 0
    While(i < PageScripts.length)
        PageScripts[i].OnConfigClose()
        i += 1
    EndWhile
EndEvent

; === SKYUI FUNCTIONS === ;

int Function GetVersion()
    return Version
EndFunction

; === UTILITY & INTERNAL FUNCTIONS === ;

MLib_Page Function GetPageScript(string page)
    {Finds the page script for the page with the specified name.}
    int i = 0
    While(i < PageScripts.length)
        If(page == Pages[i])
            return PageScripts[i]
        EndIf
        i += 1
    EndWhile

    ; Return the first page if we can't find it
    return PageScripts[0]
EndFunction
