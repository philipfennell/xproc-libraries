xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string* external;

(:
 : Returns locks of documents in a collection. : @param $URI
 : @return document-node()*
 :)

try {
	xdmp:collection-locks(xs:string($URI))
} catch($error) {
	$error
}