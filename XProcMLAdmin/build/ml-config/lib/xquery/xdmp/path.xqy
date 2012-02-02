xquery version "1.0-ml" encoding "utf-8";



declare variable $NODE as xs:string external;
declare variable $INCLUDE_DOCUMENT as xs:string* external;

(:
 : Returns a string whose value corresponds to the path of the node. : @param $NODE
 : @param $INCLUDE_DOCUMENT
 : @return xs:string
 :)

try {
	xdmp:path(node()($NODE), xs:boolean($INCLUDE_DOCUMENT))
} catch($error) {
	$error
}