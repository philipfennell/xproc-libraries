xquery version "1.0-ml" encoding "utf-8";



declare variable $MSEC as xs:string external;

(:
 : Delays for a specific amount of time. : @param $MSEC
 : @return empty-sequence()
 :)

try {
	xdmp:sleep(xs:unsignedInt($MSEC))
} catch($error) {
	$error
}