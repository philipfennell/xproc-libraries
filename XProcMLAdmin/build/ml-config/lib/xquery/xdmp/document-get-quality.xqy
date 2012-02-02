xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;

(:
 : Returns the quality of the specified document if the document exists. Otherwise, returns the empty sequence. : @param $URI
 : @return xs:integer?
 :)

try {
	xdmp:document-get-quality(xs:string($URI))
} catch($error) {
	$error
}