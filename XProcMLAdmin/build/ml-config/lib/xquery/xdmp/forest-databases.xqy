xquery version "1.0-ml" encoding "utf-8";



declare variable $FOREST as xs:string external;

(:
 : Returns the database ID corresponding to the database to which the specified forest belongs. : @param $FOREST
 : @return xs:unsignedLong
 :)

try {
	xdmp:forest-databases(xs:unsignedLong($FOREST))
} catch($error) {
	$error
}