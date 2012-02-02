xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string* external;

(:
 : Returns the locks for one or more documents or directories. Returns the locks for all documents and directories in the database if no parameter is given. : @param $URI
 : @return document-node()*
 :)

try {
	xdmp:document-locks(xs:string($URI))
} catch($error) {
	$error
}