xquery version "1.0-ml" encoding "utf-8";



declare variable $X as xs:string external;
declare variable $Y as xs:string external;

(:
 : Muliply two 64-bit integer values, discarding overflow. : @param $X
 : @param $Y
 : @return xs:unsignedLong
 :)

try {
	xdmp:mul64(xs:unsignedLong($X), xs:unsignedLong($Y))
} catch($error) {
	$error
}