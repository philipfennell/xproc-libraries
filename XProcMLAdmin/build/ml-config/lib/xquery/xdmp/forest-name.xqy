xquery version "1.0-ml" encoding "utf-8";



declare variable $ID as xs:string external;

(:
 : Return the name of the forest with the given id. : @param $ID
 : @return xs:string
 :)

try {
	xdmp:forest-name(xs:unsignedLong($ID))
} catch($error) {
	$error
}