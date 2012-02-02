xquery version "1.0-ml" encoding "utf-8";



declare variable $KEY as xs:string external;

(:
 : Construct a QName from a string of the form "{namespaceURI}localname". This function is useful for constructing Clark notation parameters for the xdmp:xslt-eval and xdmp:xslt-invoke functions. : @param $KEY
 : @return xs:QName
 :)

try {
	xdmp:QName-from-key(xs:string($KEY))
} catch($error) {
	$error
}