xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string* external;

(:
 : Returns a sequence of properties documents, one for each document in the specified collection(s) that has a corresponding properties document. : @param $URI
 : @return document-node()*
 :)

try {
	xdmp:collection-properties(xs:string($URI))
} catch($error) {
	$error
}