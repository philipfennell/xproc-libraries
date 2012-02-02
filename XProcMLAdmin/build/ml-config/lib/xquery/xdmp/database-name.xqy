xquery version "1.0-ml" encoding "utf-8";



declare variable $ID as xs:string external;

(:
 : Return the name of the database with the given ID. : @param $ID
 : @return xs:string
 :)

try {
	xdmp:database-name(xs:unsignedLong($ID))
} catch($error) {
	$error
}