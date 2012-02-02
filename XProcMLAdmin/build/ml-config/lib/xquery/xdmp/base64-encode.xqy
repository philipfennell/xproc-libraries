xquery version "1.0-ml" encoding "utf-8";



declare variable $PLAINTEXT as xs:string external;

(:
 : Converts plaintext into base64-encoded string. : @param $PLAINTEXT
 : @return xs:string
 :)

try {
	xdmp:base64-encode(xs:string($PLAINTEXT))
} catch($error) {
	$error
}