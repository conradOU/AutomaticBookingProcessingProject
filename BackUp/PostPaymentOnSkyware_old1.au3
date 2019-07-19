#include-once

Func PostPaymentOnSkyware()
	;only get to the question about posting if it 1. wasn't agoda/expedia/booking.com prepaid but yes if it was for today 3. room was successfully allocated 4. it wasn't a cancellation
		;1. 2. If $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bIsItForToday = Flase Then Exit 3. just do the call to this function inside the correct if statement 4. script won't get to this point if it was a cancellation
		;^above problem solved by making a call to this function in the right place
	;$g_sClipboardWithBookingNumber - search that for advanced rates and yes, suggest that as amount to post
	  ;"Non-refundable" booking.com, "non refundable" siteminder, "Non Refundable" expedia - if found, sugest to post full amount
		 ;if not, sugest to just post the rate, unless it's a prepaid and for today, then suggest to post the full amount. If prepaid = True And $g_bIsItForToday = True Then post the full amount
		 ;
	;$g_sSkywareArrivalRateNumberOfRooms - this contains the rate per night
		;once you can read the rate plan, then the script will be able to decide to copy correct ammount of £ for faster posting later on.
   ;EmailDeclainedBookingToLen()


EndFunc
