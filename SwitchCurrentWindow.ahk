#Requires AutoHotkey v2.0

; ==============================================================================
; BASIC MODE (Switches across 2 windows max.)
; ==============================================================================

; Alt + `
!`::
{
    current_process_name := WinGetProcessName("A")
    current_id := WinGetID("A")

    ; All Windows Open
    ids := WinGetList()

    for this_id in ids
    {
        this_process_name := WinGetProcessName(this_id)
        this_title := WinGetTitle(this_id)

        ; 1. Make sure process is the same. (e.g. switch between Code.exe)
        if (this_process_name != current_process_name)
            continue

        ; 2. Make sure ids are not the same. (we want to switch to a different id, not this one).
        if (this_id == current_id)
            continue

        ; Success
        WinActivate this_id
        break
    }

}

; ==============================================================================
; COMPLEX MODE (Switches Across More than 2 of a window.) Very experimental.
; ==============================================================================

; ; Global state for ordering.
; previous_ids_map := Map()

; ; Global state for checking previous processes.
; previous_process_name := false ; false means nothing

; ; Alt + `
; !`::
; {
;     global previous_process_name
;     global previous_ids_map

;     ; Initialize:
;     current_id := WinGetID("A")
;     current_process_name := WinGetProcessName("A")

;     if (current_process_name !== previous_process_name)
;         previous_ids_map := Map()

;     ; All Windows Open
;     ids := WinGetList()

;     local switchable_ids := Array()

;     for this_id in ids
;     {
;         this_process_name := WinGetProcessName(this_id)
;         this_title := WinGetTitle(this_id)

;         ; 1. Make sure process is the same. (e.g. switch between Code.exe)
;         if (this_process_name != current_process_name)
;             continue


;         switchable_ids.Push(this_id)
;     }

;     for id in switchable_ids
;     {
;         ; 1. Make sure ids are not the same. (we want to switch to a different id, not this one).
;         if (id == current_id)
;             continue

;         ; 2. Make sure to use an ID that hasn't been used previously.
;         if (previous_ids_map.Has(id))
;             continue

;         WinActivate id
;         previous_ids_map[id] := 1 ; Mark as used.
;         break
;     }

;     ; Exit
;     previous_process_name := current_process_name

;     if (previous_ids_map.Count == switchable_ids.Length) {
;         previous_ids_map := Map()
;     }
; }
