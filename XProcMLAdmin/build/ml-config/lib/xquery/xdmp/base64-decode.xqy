xquery version "1.0-ml" encoding "utf-8";



declare variable $ENCODED as xs:string external;

(:
 : Converts base64-encoded string to plaintext. : @param $ENCODED
 : @return xs:string
 :)

try {
	xdmp:base64-decode(xs:string($ENCODED))
} catch($error) {
	$error
}