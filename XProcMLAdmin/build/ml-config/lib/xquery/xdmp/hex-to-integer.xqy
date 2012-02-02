xquery version "1.0-ml" encoding "utf-8";



declare variable $HEX as xs:string external;

(:
 : Parses a hexadecimal string, returning an integer. : @param $HEX
 : @return xs:integer
 :)

try {
	xdmp:hex-to-integer(xs:string($HEX))
} catch($error) {
	$error
}