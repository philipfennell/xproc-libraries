xquery version "1.0-ml" encoding "utf-8";



declare variable $NAME as xs:string external;

(:
 : Construct a context-independent string from a QName. This string is of the form "{namespaceURI}localname" and is suitable for use as a map key. : @param $NAME
 : @return xs:string
 :)

try {
	xdmp:key-from-QName(xs:QName($NAME))
} catch($error) {
	$error
}