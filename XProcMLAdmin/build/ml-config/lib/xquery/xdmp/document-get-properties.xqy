xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $PROPERTY as xs:string external;

(:
 : Returns the property values for a document's property. : @param $URI
 : @param $PROPERTY
 : @return element()*
 :)

try {
	xdmp:document-get-properties(xs:string($URI), xs:QName($PROPERTY))
} catch($error) {
	$error
}