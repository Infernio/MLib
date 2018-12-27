ScriptName MLib_Utils Hidden
{Several utility functions used by MLib.}

; === ARRAYS === ;

Int[] Function ExtendIntArray(Int[] array, Int by) Global
    {Extends the specified integer array by the specified Length, unless doing so would make it exceed 128 elements.}
    If(array.Length == 128)
        return array
    EndIf

    Int[] newArray = Utility.CreateIntArray(Min(128, array.Length + by))
    Int i = 0
    While(i < array.Length)
        newArray[i] = array[i]
        i += 1
    EndWhile

    return newArray
EndFunction

String[] Function ExtendStringArray(String[] array, Int by) Global
    {Extends the specified String array by the specified Length, unless doing so would make it exceed 128 elements.}
    If(array.Length == 128)
        return array
    EndIf

    String[] newArray = Utility.CreateStringArray(Min(128, array.Length + by))
    Int i = 0
    While(i < array.Length)
        newArray[i] = array[i]
        i += 1
    EndWhile

    return newArray
EndFunction

Form[] Function ExtendFormArray(Form[] array, Int by) Global
    {Extends the specified form array by the specified Length, unless doing so would make it exceed 128 elements.}
    If(array.Length == 128)
        return array
    EndIf

    Form[] newArray = Utility.CreateFormArray(Min(128, array.Length + by))
    Int i = 0
    While(i < array.Length)
        newArray[i] = array[i]
        i += 1
    EndWhile

    return newArray
EndFunction

; === MATH === ;
Int Function Max(Int a, Int b) Global
    {Returns the larger of the two integers.}
    If(a > b)
        return a
    Else
        return b
    EndIf
EndFunction

Int Function Min(Int a, Int b) Global
    {Returns the smaller of the two integers.}
    If(a < b)
        return a
    Else
        return b
    EndIf
EndFunction

; === OPTION TYPES === ;

; The following are basically just constants used by MLib_Page in order to make backwards compatibility easier
Int Function TypeEmpty() Global
    return 0
EndFunction

Int Function TypeHeader() Global
    return 1
EndFunction

Int Function TypeText() Global
    return 2
EndFunction

Int Function TypeToggle() Global
    return 3
EndFunction

Int Function TypeSlider() Global
    return 5
EndFunction

Int Function TypeMenu() Global
    return 6
EndFunction

Int Function TypeColor() Global
    return 7
EndFunction

Int Function TypeKeyMap() Global
    return 8
EndFunction

Int Function TypeInput() Global
    return 9
EndFunction

Int Function TypeGVToggle() Global
    return 10
EndFunction

Int Function TypeGVSlider() Global
    return 11
EndFunction
