xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $DEPTH as xs:string* external;

(:
 : Returns the documents in a directory. : @param $URI
 : @param $DEPTH
 : @return document-node()*
 :)

try {
	xdmp:directory(xs:string($URI), xs:string($DEPTH))
} catch($error) {
	$error
}