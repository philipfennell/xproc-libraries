xquery version "1.0-ml" encoding "utf-8";



declare variable $X as xs:string external;
declare variable $Y as xs:string external;

(:
 : Left-shift a 64-bit integer value. : @param $X
 : @param $Y
 : @return xs:unsignedLong
 :)

try {
	xdmp:lshift64(xs:unsignedLong($X), xs:integer($Y))
} catch($error) {
	$error
}