xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $ACTION as xs:string external;

(:
 : Returns whether a given action on the specified document URI would succeed. : @param $URI
 : @param $ACTION
 : @return xs:boolean
 :)

try {
	xdmp:access(xs:string($URI), xs:string($ACTION))
} catch($error) {
	$error
}