xquery version "1.0-ml" encoding "utf-8";



declare variable $OCTAL as xs:string external;

(:
 : Parses an octal string, returning an integer. : @param $OCTAL
 : @return xs:integer
 :)

try {
	xdmp:octal-to-integer(xs:string($OCTAL))
} catch($error) {
	$error
}