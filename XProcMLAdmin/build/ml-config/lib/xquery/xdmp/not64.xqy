xquery version "1.0-ml" encoding "utf-8";



declare variable $X as xs:string external;

(:
 : NOT a 64-bit integer value. : @param $X
 : @return xs:unsignedLong
 :)

try {
	xdmp:not64(xs:unsignedLong($X))
} catch($error) {
	$error
}