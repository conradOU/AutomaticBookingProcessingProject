#include "Constants.au3"
#include-once

;;;;
Enum $firstParam, $secondParam, $thirdParam, $fourthParam
;;;; these were defined in Main, delete after testing and including this function in main()

;it will continue once it gets READY, so there is no need to send ENTER inside this function
;uses: PostFullAmountForPrepaid.au3 ln 62,

Func CheckIfPageIsLoaded()

	Local Const $FirefoxWaitingForChecksum = 3130071720
	Local Const $FirefoxTransferringChecksum = 2133603907
	Local Const $FirefoxReadChecksum = 3404994627 ;it literally says "Read"
	Local Const $aFirefoxLoadingStatusBarLocation[4] = [5, 840, 30, 855]
	;check the above constants at the Albany as well
	Local $bWasFirefoxTransferringVisible = False
	Local $iTimeoutCounter = 0
	Local Const $iTimeoutInMS = 2000

	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;wait to the browser to respond and even render the status bar to begin with

	While ($FirefoxReadChecksum <> PixelChecksum( _
			$aFirefoxLoadingStatusBarLocation[$firstParam], _
			$aFirefoxLoadingStatusBarLocation[$secondParam], _
			$aFirefoxLoadingStatusBarLocation[$thirdParam], _
			$aFirefoxLoadingStatusBarLocation[$fourthParam]))

		If $FirefoxTransferringChecksum == PixelChecksum( _
				$aFirefoxLoadingStatusBarLocation[$firstParam], _
				$aFirefoxLoadingStatusBarLocation[$secondParam], _
				$aFirefoxLoadingStatusBarLocation[$thirdParam], _
				$aFirefoxLoadingStatusBarLocation[$fourthParam]) Then

			$bWasFirefoxTransferringVisible = True

		EndIf

		If $bWasFirefoxTransferringVisible = True _
				And _
				$FirefoxTransferringChecksum <> PixelChecksum( _
				$aFirefoxLoadingStatusBarLocation[$firstParam], _
				$aFirefoxLoadingStatusBarLocation[$secondParam], _
				$aFirefoxLoadingStatusBarLocation[$thirdParam], _
				$aFirefoxLoadingStatusBarLocation[$fourthParam]) _
				And _
				$FirefoxWaitingForChecksum <> PixelChecksum( _
				$aFirefoxLoadingStatusBarLocation[$firstParam], _
				$aFirefoxLoadingStatusBarLocation[$secondParam], _
				$aFirefoxLoadingStatusBarLocation[$thirdParam], _
				$aFirefoxLoadingStatusBarLocation[$fourthParam]) Then

			Sleep($LOADING_TIME_SLOW_PC_RELATED)
			Return "loaded, no $FirefoxReadChecksum catched"

		EndIf

		$iTimeoutCounter += 50
		Sleep(50)

		If $bWasFirefoxTransferringVisible = False _
				And _
				$FirefoxTransferringChecksum <> PixelChecksum( _
				$aFirefoxLoadingStatusBarLocation[$firstParam], _
				$aFirefoxLoadingStatusBarLocation[$secondParam], _
				$aFirefoxLoadingStatusBarLocation[$thirdParam], _
				$aFirefoxLoadingStatusBarLocation[$fourthParam]) _
				And _
				$FirefoxWaitingForChecksum <> PixelChecksum( _
				$aFirefoxLoadingStatusBarLocation[$firstParam], _
				$aFirefoxLoadingStatusBarLocation[$secondParam], _
				$aFirefoxLoadingStatusBarLocation[$thirdParam], _
				$aFirefoxLoadingStatusBarLocation[$fourthParam]) _
				And _
				$iTimeoutCounter >= $iTimeoutInMS Then

			Return True
		EndIf

	WEnd
	;make sure to wait afterwards, as the page is still renedering

	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Return True     ;if it cought FirefoxReadChecksum then sleep and Return from the function

EndFunc   ;==>CheckIfPageIsLoaded