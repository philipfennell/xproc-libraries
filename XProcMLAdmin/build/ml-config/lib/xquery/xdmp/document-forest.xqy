xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $FOREST_IDS as xs:string* external;

(:
 : Returns the forest ID of the forest in which a document (or a lock or a property) with the specified URI is stored. Otherwise, returns the empty sequence. : @param $URI
 : @param $FOREST_IDS
 : @return xs:integer?
 :)

try {
	xdmp:document-forest(xs:string($URI), xs:unsignedLong($FOREST_IDS))
} catch($error) {
	$error
}