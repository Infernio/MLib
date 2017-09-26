ScriptName MLib_Page Extends ReferenceAlias
{This script defines a single MCM page. It will only receive events for that page and also includes some functions to make designing MCMs simpler.}

import MLib_Utils

; PROPERTIES
MLib_Config Property Config Auto Hidden
{The config that this page is attached to.}
int[]       Property OptionIDs Auto Hidden
{The IDs of options added to this page.}
int[]       Property OptionTypes Auto Hidden
{The types of options added to this page.}
Form[]      Property OptionGVs Auto Hidden
{The global variables belonging to the respective options.}
string[]    Property OptionHovers Auto Hidden
{The strings shown to the player when they hover over options.}

; PROPERTIES MIRRORED FROM SKYUI
int Property STATE_DEFAULT  = 0 AutoReadOnly
int Property STATE_RESET    = 1 AutoReadOnly
int Property STATE_SLIDER   = 2 AutoReadOnly
int Property STATE_MENU     = 3 AutoReadOnly
int Property STATE_COLOR    = 4 AutoReadOnly

int Property OPTION_TYPE_EMPTY  = 0x00 AutoReadOnly
int Property OPTION_TYPE_HEADER = 0x01 AutoReadOnly
int Property OPTION_TYPE_TEXT   = 0x02 AutoReadOnly
int Property OPTION_TYPE_TOGGLE = 0x03 AutoReadOnly
int Property OPTION_TYPE_SLIDER = 0x04 AutoReadOnly
int Property OPTION_TYPE_MENU   = 0x05 AutoReadOnly
int Property OPTION_TYPE_COLOR  = 0x06 AutoReadOnly
int Property OPTION_TYPE_KEYMAP = 0x07 AutoReadOnly

int Property OPTION_FLAG_NONE       = 0x00 AutoReadOnly
int Property OPTION_FLAG_DISABLED   = 0x01 AutoReadOnly
int Property OPTION_FLAG_HIDDEN     = 0x02 AutoReadOnly
int Property OPTION_FLAG_WITH_UNMAP = 0x04 AutoReadOnly

int Property LEFT_TO_RIGHT = 1 AutoReadOnly
int Property TOP_TO_BOTTOM = 2 AutoReadOnly

; VARIABLES
int currentOption = 0
int numOptions = 10

; === OVERRIDABLE EVENTS AND FUNCTIONS === ;

Event OnPageInit()
    {Called when this page is first created. Mirrors SkyUI's OnConfigInit.}
    ; Should get overridden
EndEvent

Event OnPageReset()
    {Mirrors SkyUI's OnPageReset, except it doesn't receive the current page as a parameter (for obvious reasons).}
    ; Should get overridden
EndEvent

Event OnOptionSelect(int option)
    {Mirrors SkyUI's OnOptionSelect, but only gets called for options that are on this page.}
    ; Should get overridden
EndEvent

Event OnOptionHighlight(int option)
    {Mirrors SkyUI's OnOptionHighlight, but only gets called for options that are on this page.}
    ; Should get overridden
EndEvent

Event OnVersionUpdate(int oldVersion, int newVersion)
    {Called on each page when the MCM script is updated to a new version.}
    ; Should get overridden
EndEvent

string Function GetTitle()
    {Returns this page's title that will be displayed in the MCM. You should override this method in your page scripts.}
    return "Override GetTitle()"
EndFunction

string Function TranslateMenuOption(int option, int selection)
    {Returns a human-readable translation of the specified selection for the specified menu option.}
    return selection as string
EndFunction

; === SKYUI FUNCTION MIRRORS === ;

; Title and Info Text
Function SetTitleText(string text)
    {Identical to SkyUI's SetTitleText.}
    Config.SetTitleText(text)
EndFunction

Function SetInfoText(string text)
    {Identical to SkyUI's SetInfoText.}
    Config.SetInfoText(text)
EndFunction

int Function AddEmptyOption()
    {Identical to SkyUI's AddEmptyOption.}
    return Config.AddEmptyOption()
EndFunction

; Add Options
int Function AddHeaderOption(string text, int flags = 0)
    {Identical to SkyUI's AddHeaderOption.}
    return Config.AddHeaderOption(text, flags)
EndFunction

int Function AddTextOption(string text, string value, int flags = 0, string hover = "")
    {Similar to SkyUI's AddTextOption, but this one also accepts an optional string that should be displayed when hovering over the option.}
    int ret = Config.AddTextOption(text, value, flags)
    _AddHoverInfo(ret, TypeText(), hover)
    return ret
EndFunction

int Function AddToggleOption(string text, bool checked, int flags = 0, string hover = "")
    {Similar to SkyUI's AddToggleOption, but this one also accepts an optional string that should be displayed when hovering over the option.}
    int ret = Config.AddToggleOption(text, checked, flags)
    _AddHoverInfo(ret, TypeToggle(), hover)
    return ret
EndFunction

int Function AddSliderOption(string text, float value, string formatString = "{0}", int flags = 0, string hover = "")
    {Similar to SkyUI's AddSliderOption, but this one also accepts an optional string that should be displayed when hovering over the option.}
    int ret = Config.AddSliderOption(text, value, formatString, flags)
    _AddHoverInfo(ret, TypeSlider(), hover)
    return ret
EndFunction

int Function AddMenuOption(string text, string value, int flags = 0, string hover = "")
    {Similar to SkyUI's AddMenuOption, but this one also accepts an optional string that should be displayed when hovering over the option.}
    int ret = Config.AddMenuOption(text, value, flags)
    _AddHoverInfo(ret, TypeMenu(), hover)
    return ret
EndFunction

int Function AddColorOption(string text, int color, int flags = 0, string hover = "")
    {Similar to SkyUI's AddColorOption, but this one also accepts an optional string that should be displayed when hovering over the option.}
    int ret = Config.AddColorOption(text, color, flags)
    _AddHoverInfo(ret, TypeColor(), hover)
    return ret
EndFunction

int Function AddKeyMapOption(string text, int keyCode, int flags = 0, string hover = "")
    {Similar to SkyUI's AddKeyMapOption, but this one also accepts an optional string that should be displayed when hovering over the option.}
    int ret = Config.AddKeyMapOption(text, keyCode, flags)
    _AddHoverInfo(ret, TypeKeyMap(), hover)
    return ret
EndFunction

int Function AddInputOption(string text, string value, int flags = 0, string hover = "")
    {Similar to SkyUI's AddInputOption, but this one also accepts an optional string that should be displayed when hovering over the option.}
    int ret = Config.AddInputOption(text, value, flags)
    _AddHoverInfo(ret, TypeInput(), hover)
    return ret
EndFunction

; Cursor
Function SetCursorPosition(int position)
    {Identical to SkyUI's SetCursorPosition.}
    Config.SetCursorPosition(position)
EndFunction

Function SetCursorFillMode(int fillMode)
    {Identical to SkyUI's SetCursorFillMode.}
    Config.SetCursorFillMode(fillMode)
EndFunction

; Custom Content
Function LoadCustomContent(string source, float x = 0.0, float y = 0.0)
    {Identical to SkyUI's LoadCustomContent.}
    Config.LoadCustomContent(source, x, y)
EndFunction

Function UnloadCustomContent()
    {Identical to SkyUI's UnloadCustomContent.}
    Config.UnloadCustomContent()
EndFunction

; Set Values
Function SetOptionFlags(int option, int flags, bool noUpdate = false)
    {Identical to SkyUI's SetOptionFlags.}
    Config.SetOptionFlags(option, flags, noUpdate)
EndFunction

Function SetTextOptionValue(int option, string value, bool noUpdate = false)
    {Identical to SkyUI's SetTextOptionValue.}
    Config.SetTextOptionValue(option, value, noUpdate)
EndFunction

Function SetToggleOptionValue(int option, bool checked, bool noUpdate = false)
    {Identical to SkyUI's SetToggleOptionValue.}
    Config.SetToggleOptionValue(option, checked, noUpdate)
EndFunction

Function SetMenuOptionValue(int option, string value, bool noUpdate = false)
    {Identical to SkyUI's SetMenuOptionValue.}
    Config.SetMenuOptionValue(option, value, noUpdate)
EndFunction

; ShowMessage & ForcePageReset
bool Function ShowMessage(string msg, bool withCancel = true, string acceptLabel = "$Accept", string cancelLabel = "$Cancel")
    {Identical to SkyUI's ShowMessage.}
    return Config.ShowMessage(msg, withCancel, acceptLabel, cancelLabel)
EndFunction

Function ForcePageReset()
    {Identical to SkyUI's ForcePageReset.}
    Config.ForcePageReset()
EndFunction

; === CUSTOM SKYUI EXTENSIONS === ;

int Function AddGVToggleOption(string text, GlobalVariable var, int flags = 0, string hover = "")
    {Adds a global variable toggle. This GV will automatically get updated whenever the option is toggled.}
    int ret = Config.AddToggleOption(text, var.GetValue() == 1, flags)
    _AddHoverInfoGV(ret, TypeGVToggle(), hover, var)
    return ret
EndFunction

int Function AddGVSliderOption(string text, GlobalVariable var, int flags = 0, string hover = "")
    {Adds a global variable slider. This GV will automatically get updated whenever the slider is moved.}
    int ret = Config.AddSliderOption(text, var.GetValue(), flags)
    _AddHoverInfoGV(ret, TypeGVSlider(), hover, var)
    return ret
EndFunction

int Function AddGVMenuOption(string text, GlobalVariable var, int flags = 0, string hover = "")
    {Adds a global variable menu. This GV will automatically get updated whenever an item is selected.}
    int ret = Config.AddMenuOption(text, "", flags)
    Config.SetMenuOptionValue(ret, TranslateMenuOption(ret, var.GetValue() as int))
    _AddHoverInfoGV(ret, TypeGVSlider(), hover, var)
    return ret
EndFunction

; === INTERNAL FUNCTIONS === ;

Function _InitPage(MLib_Config cfg)
    {Initializes the entire page. Do not override this - override OnPageInit instead.}
    Config = cfg
    OnPageInit()
EndFunction

Function _ResetPage()
    {Resets the entire page. Do not override this - override OnPageReset instead.}
    Debug.MessageBox("_ResetPage() called")
    OptionIDS = Utility.CreateIntArray(numOptions)
    OptionGVs = Utility.CreateFormArray(numOptions)

    ; Add the actual components and then remember how many there were for next time
    OnPageReset()
    numOptions = currentOption
EndFunction

Function _SelectOption(int option)
    {Selects an option from this page. Do not override this - override OnOptionSelect instead.}
    int i = FindOptionWithType(option, TypeGVToggle())
    If(i >= 0)
        ; Handle global variable toggles
        GlobalVariable var = OptionGVs[i] as GlobalVariable
        bool newValue = var.GetValue() == 0
        var.SetValue(newValue as float)
        Config.SetToggleOptionValue(option, newValue)
    Else
        ; Otherwise, ask the page script to handle this
        OnOptionSelect(option)
    EndIf
EndFunction

Function _HighlightOption(int option)
    {Highlights an option on this page. Do not override this - override OnOptionHighlight instead.}
    int i = FindOption(option)
    If(i >= 0)
        ; If we found it, set the info text appropriately
        SetInfoText(OptionHovers[i])
    EndIf

    ; In any case, let the page script override this
    OnOptionHighlight(option)
EndFunction

Function _CheckArraySizes()
    {Checks to make sure we haven't exceeded our array capacities yet. If we did, it extends the arrays to fit.}
    If(currentOption >= numOptions)
        numOptions += 10
        OptionIDs = ExtendIntArray(OptionIDs, 10)
        OptionTypes = ExtendIntArray(OptionTypes, 10)
        OptionGVs = ExtendFormArray(OptionGVs, 10)
        OptionHovers = ExtendStringArray(OptionHovers, 10)
    EndIf
EndFunction

Function _AddHoverInfo(int ret, int type, string hover)
    {Adds info for an option with a hover text to the page and updates all relevant arrays and variables.}
    OptionIDs[currentOption] = ret
    OptionTypes[currentOption] = type
    OptionHovers[currentOption] = hover
    currentOption += 1
    _CheckArraySizes()
EndFunction

Function _AddHoverInfoGV(int ret, int type, string hover, GlobalVariable var)
    {Adds info for a global variable option with a hover text to the page and updates all relevant arrays and variables.}
    OptionGVs[currentOption] = var
    _AddHoverInfo(ret, type, hover)
EndFunction

; === UTILTIY FUNCTIONS === ;

int Function FindOption(int option)
    {Finds the index of an option with the specified ID in the option array, or -1 if such an option could not be found.}
    int i = 0
    While(i < OptionIDs.length)
        If(option == OptionIDs[i])
            return i
        EndIf
        i += 1
    EndWhile

    ; Return -1 to signal that we didn't find it
    return -1
EndFunction

int Function FindOptionWithType(int option, int type)
    {Finds the index of an option with the specified ID and type in the option array, or -1 if such an option could not be found.}
    int i = 0
    While(i < OptionIDs.length)
        If(option == OptionIDs[i] && type == OptionTypes[i])
            return i
        EndIf
        i += 1
    EndWhile

    ; Return -1 to signal that we didn't find it
    return -1
EndFunction
