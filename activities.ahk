; Mimic GNOME Shell's Top-left corner on Windows 10
;
; Hit top left corner with your cursor to show task view.
; Also works on multi-monitor setup.

#persistent
#WinActivateForce

size = 5
activating =
coordmode mouse, screen
settimer activities, 200
return

is_hot(size)
{
    mousegetpos x, y
    sysget mon_count, monitorcount
    loop %mon_count%
    {
        sysget mon, monitor, %a_index%
        if (x < monleft + size and y < montop + size and x >= monleft and y >= montop)
            return true
    }
    return false
}

activities:
    in_hot_corner := is_hot(size)

    if (activating and not in_hot_corner)
        activating =

    if (not activating and in_hot_corner)
    {
        activating = true

        ifwinnotactive ahk_exe explorer.exe
            winactivate ahk_exe explorer.exe

        send, #`t       ; super + tab
    }

    return

