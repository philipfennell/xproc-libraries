xquery version "1.0-ml" encoding "utf-8";



declare variable $ENCODED as xs:string external;
declare variable $ENCODING_NAME as xs:string external;

(:
 : Converts an encoded byte sequence, passed in as a binary node, from the specified encoding to a unicode string. : @param $ENCODED
 : @param $ENCODING_NAME
 : @return xs:string
 :)

try {
	xdmp:binary-decode(node()($ENCODED), xs:string($ENCODING_NAME))
} catch($error) {
	$error
}