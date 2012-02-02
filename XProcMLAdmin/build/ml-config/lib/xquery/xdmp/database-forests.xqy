xquery version "1.0-ml" encoding "utf-8";



declare variable $DATABASE as xs:string external;
declare variable $INCLUDE_REPLICAS as xs:string* external;

(:
 : Returns a sequence of forest IDs in the specified database. : @param $DATABASE
 : @param $INCLUDE_REPLICAS
 : @return xs:unsignedLong*
 :)

try {
	xdmp:database-forests(xs:unsignedLong($DATABASE), xs:boolean($INCLUDE_REPLICAS))
} catch($error) {
	$error
}