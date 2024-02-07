#Requires AutoHotkey v2.0

; ==============================================================================
; BASIC MODE (Switches across 2 windows max.)
; ==============================================================================

; ; Alt + `
; !`::
; {
;     if !WinExist("A")
;         return

;     current_process_name := WinGetProcessName("A")
;     current_id := WinGetID("A")

;     ; All Windows Open
;     ids := WinGetList()

;     for this_id in ids
;     {
;         this_process_name := WinGetProcessName(this_id)
;         this_title := WinGetTitle(this_id)

;         ; 1. Make sure process is the same. (e.g. switch between Code.exe)
;         if (this_process_name != current_process_name)
;             continue

;         ; 2. Make sure ids are not the same. (we want to switch to a different id, not this one).
;         if (this_id == current_id)
;             continue

;         ; Success
;         WinActivate this_id
;         break
;     }
; }

; ==============================================================================
; COMPLEX MODE (Switches Across More than 2 of a window.)
; ==============================================================================

; join(strArray)
; {
;     s := ""
;     for i, v in strArray
;         s .= ", " . v
;     return substr(s, 3)
; }

; For makign sure that `keyArray` is the same as `keyMap`
allItemsAreInMapKeys(keyArray, keyMap)
{
    ; If even one key doesn't exist, return false.
    for key in keyArray
    {
        if (!keyMap.Has(key))
            return false
    }

    ; All keys exist, return true.
    return true
}

; Initializes the switchable ids by the active first in the order.
initializeOrderedIds(switchable_ids, activeId)
{
    ; I. Find Active.
    local index_of_active := 1

    for id in switchable_ids
    {
        if (id == activeId)
            index_of_active := A_Index
    }

    ; II. Construct Ordered Array.
    local ordered_ids := Array()
    local current_index := index_of_active
    while ordered_ids.Length != switchable_ids.Length
    {
        ; 1. Add to array.
        ordered_ids.Push(switchable_ids[current_index])

        ; 2. Increment.
        current_index := current_index + 1

        ; 3. Circle back to start when reached end.
        if (current_index > switchable_ids.Length)
            current_index := 1
    }

    return ordered_ids
}

getSwitchableIds(all_window_ids, current_process_name)
{
    local switchable_ids := Array()

    for this_id in all_window_ids
    {
        this_process_name := WinGetProcessName(this_id)

        ; 1. Make sure process is the same. (e.g. switch between Code.exe)
        if (this_process_name != current_process_name)
            continue

        switchable_ids.Push(this_id)
    }

    return switchable_ids
}

; Ids ordered with the active to be first.
ordered_ids := Array()

; Global state for offset
offset := 1

; Global state for checking-exists.
cached_ids_map := Map()

; Global state for checking previous processes.
previous_process_name := false ; false means nothing

; Alt + `
!`::
{
    global ordered_ids
    global offset
    global cached_ids_map
    global previous_process_name

    active_id := WinGetID("A")
    current_process_name := WinGetProcessName("A")

    if (current_process_name !== previous_process_name)
    {
        cached_ids_map := Map()
    }

    all_window_ids := WinGetList()

    local switchable_ids := getSwitchableIds(all_window_ids, current_process_name)

    local is_same_ids := allItemsAreInMapKeys(switchable_ids, cached_ids_map)

    if (!is_same_ids) {
        ordered_ids := initializeOrderedIds(switchable_ids, active_id)
        offset := 1
    }

    if (ordered_ids.Length > 1) {
        offset := offset + 1
    }

    if (offset > ordered_ids.Length)
        offset := 1

    if WinExist(ordered_ids[offset])
        WinActivate ordered_ids[offset]

    for id in switchable_ids {
        cached_ids_map[id] := 1
    }
    previous_process_name := current_process_name
}