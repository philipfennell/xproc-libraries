xquery version "1.0-ml" encoding "utf-8";



declare variable $STRING as xs:string external;

(:
 : Returns the 64-bit hash of a string. : @param $STRING
 : @return xs:unsignedLong
 :)

try {
	xdmp:hash64(xs:string($STRING))
} catch($error) {
	$error
}