xquery version "1.0-ml" encoding "utf-8";



declare variable $INITIAL as xs:string external;
declare variable $STEP as xs:string external;

(:
 : Combines an initial hash with a subsequent hash. : @param $INITIAL
 : @param $STEP
 : @return xs:unsignedLong
 :)

try {
	xdmp:step64(xs:unsignedLong($INITIAL), xs:unsignedLong($STEP))
} catch($error) {
	$error
}