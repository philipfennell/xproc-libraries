xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $DEPTH as xs:string* external;

(:
 : Returns a sequence of properties documents, one for each document in the specified directory that has a corresponding properties document. : @param $URI
 : @param $DEPTH
 : @return document-node()*
 :)

try {
	xdmp:directory-properties(xs:string($URI), xs:string($DEPTH))
} catch($error) {
	$error
}