xquery version "1.0-ml" encoding "utf-8";



declare variable $STRING as xs:string external;

(:
 : Returns the 32-bit hash of a string. : @param $STRING
 : @return xs:unsignedInt
 :)

try {
	xdmp:hash32(xs:string($STRING))
} catch($error) {
	$error
}