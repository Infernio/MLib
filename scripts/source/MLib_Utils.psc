ScriptName MLib_Utils Hidden
{Several utility functions used by MLib.}

; === ARRAYS === ;

int[] Function ExtendIntArray(int[] array, int by) global
    {Extends the specified integer array by the specified length, unless doing so would make it exceed 128 elements.}
    If(array.length == 128)
        return array
    EndIf

    int[] newArray = Utility.CreateIntArray(Min(128, array.length + by))
    int i = 0
    While(i < array.length)
        newArray[i] = array[i]
        i += 1
    EndWhile

    return newArray
EndFunction

string[] Function ExtendStringArray(string[] array, int by) global
    {Extends the specified string array by the specified length, unless doing so would make it exceed 128 elements.}
    If(array.length == 128)
        return array
    EndIf

    string[] newArray = Utility.CreateStringArray(Min(128, array.length + by))
    int i = 0
    While(i < array.length)
        newArray[i] = array[i]
        i += 1
    EndWhile

    return newArray
EndFunction

Form[] Function ExtendFormArray(Form[] array, int by) global
    {Extends the specified form array by the specified length, unless doing so would make it exceed 128 elements.}
    If(array.length == 128)
        return array
    EndIf

    Form[] newArray = Utility.CreateFormArray(Min(128, array.length + by))
    int i = 0
    While(i < array.length)
        newArray[i] = array[i]
        i += 1
    EndWhile

    return newArray
EndFunction

; === MATH === ;
int Function Max(int a, int b) global
    {Returns the larger of the two integers.}
    If(a > b)
        return a
    Else
        return b
    EndIf
EndFunction

int Function Min(int a, int b) global
    {Returns the smaller of the two integers.}
    If(a < b)
        return a
    Else
        return b
    EndIf
EndFunction

; === OPTION TYPES === ;

; The following are basically just constants used by MLib_Page in order to make backwards compatibility easier
int Function TypeEmpty() global
    return 0
EndFunction

int Function TypeHeader() global
    return 1
EndFunction

int Function TypeText() global
    return 2
EndFunction

int Function TypeToggle() global
    return 3
EndFunction

int Function TypeSlider() global
    return 5
EndFunction

int Function TypeMenu() global
    return 6
EndFunction

int Function TypeColor() global
    return 7
EndFunction

int Function TypeKeyMap() global
    return 8
EndFunction

int Function TypeInput() global
    return 9
EndFunction

int Function TypeGVToggle() global
    return 10
EndFunction

int Function TypeGVSlider() global
    return 11
EndFunction
