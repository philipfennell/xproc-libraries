xquery version "1.0-ml" encoding "utf-8";



declare variable $LOCATION as xs:string external;
declare variable $OPTIONS as xs:string* external;

(:
 : Returns the document in the file specified by $location. : @param $LOCATION
 : @param $OPTIONS
 : @return node()
 :)

try {
	xdmp:document-get(xs:string($LOCATION), node()($OPTIONS))
} catch($error) {
	$error
}