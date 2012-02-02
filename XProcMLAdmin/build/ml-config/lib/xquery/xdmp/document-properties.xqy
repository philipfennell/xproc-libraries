xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string* external;

(:
 : Returns a sequence of properties documents, one for each of the specified documents that has a corresponding properties document. If no documents are specified, returns a sequence of properties documents for all documents in the database that have a corresponding properties document. : @param $URI
 : @return document-node()*
 :)

try {
	xdmp:document-properties(xs:string($URI))
} catch($error) {
	$error
}