#include <AutoItConstants.au3>
#include "..\Constants.au3"
#include "..\CheckIfPageIsLoaded.au3"

;you can definately use CheckIfPageIsLoaded() here instead of Sleep

If @UserName = "User" Then ;if YP PC
	Run(@ProgramFilesDir & "\Mozilla Firefox\firefox.exe", "", @SW_SHOWMAXIMIZED) ;tested at the YP
	WinWaitActive("[CLASS:MozillaWindowClass]")
	Sleep($LOADING_TIME_SLOW_PC_RELATED * 10)

	MouseClick("right", 74, 16, 1, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("p")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	MouseClick("right", 74, 16, 1, 0)
	Send("p")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{CTRLDOWN}3{CTRLUP}")
    CheckIfPageIsLoaded()

	Send("{SHIFTDOWN}{TAB}{SHIFTUP}")
    CheckIfPageIsLoaded()
	Send("{DOWN}")
    CheckIfPageIsLoaded()
	Send("{ENTER}")
    CheckIfPageIsLoaded()
    Send("{CTRLDOWN}l{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("https://www.skywaresystems.net/WizResvCheckIn.aspx?UserString=2627263527354456555942453526584267276460653527252634262726342632262729302632&Status=RESV&WizAct=CHECKIN&MenuRowID=1&SKYMENU=CLEAR")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")


	Send("{CTRLDOWN}4{CTRLUP}") ;mail
    CheckIfPageIsLoaded()
	Send("{TAB}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{DOWN}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{DOWN}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")

	Send("{CTRLDOWN}5{CTRLUP}")
    CheckIfPageIsLoaded()
	Send("{CTRLDOWN}l{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263527354456555942453526584267276460653527252634262726342632263427272634&MenuRowID=19&SKYMENU=CLEAR")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")

ElseIf @UserName = "Ballantrae" Then ;if albany left PC
	Run(@ProgramFilesDir & "\Mozilla Firefox\firefox.exe", "", @SW_SHOWMAXIMIZED) ;tested at the Albany
	WinWaitActive("[CLASS:MozillaWindowClass]")
	Sleep($LOADING_TIME_SLOW_PC_RELATED * 5)

	MouseClick("right", 74, 16, 1, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("p")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	MouseClick("right", 74, 16, 1, 0)
	Send("p")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{CTRLDOWN}3{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED * 10)

	Send("{ENTER}")

	Send("{CTRLDOWN}4{CTRLUP}") ;mail
	Sleep($LOADING_TIME_SLOW_PC_RELATED * 10)
	Send("{TAB}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{DOWN}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")

	Send("{CTRLDOWN}5{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{CTRLDOWN}l{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("https://www.skywaresystems.net/Dashboard.aspx?UserString=2627263526354456555942453526584267276460653527252634253427342632263227263226&XSession1=PropertyRowID--121")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
Else
	MsgBox(0, "", "" & @UserName & " is unsupported")
	Exit
EndIf

#CS
### Close chrome if running
### Unlock hidden files and open your directory
### Press the combo to open the firefox
### Pin two tabs. Possible to do with a keyboard shortcut after simulated right mouse click on the tab itself.  Then to switch tabs use ctrl plus page down keys.
### Login into skyware, switch tab
### Login into email, switch tab
### Login into skyware/open the link as you're already logged in.
###
### What you usually check:
### If there are any rooms left to check in - you can tell so from the dashboard after log in
### If you're fully booked - room chart, but not necassarly - see point above: Available  	3
### Email ofc.
###
### Base it on the Computer name, to make it more automatic.
### Assign the script to the shortcut, the same as before - alt ctrl 1
#CE
