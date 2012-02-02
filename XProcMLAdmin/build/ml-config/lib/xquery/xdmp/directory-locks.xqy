xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $DEPTH as xs:string* external;

(:
 : Returns locks of documents in a directory. : @param $URI
 : @param $DEPTH
 : @return document-node()*
 :)

try {
	xdmp:directory-locks(xs:string($URI), xs:string($DEPTH))
} catch($error) {
	$error
}