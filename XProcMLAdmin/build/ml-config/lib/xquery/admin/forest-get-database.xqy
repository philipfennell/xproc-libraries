xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;

(:
 : This function returns the ID of the database that uses the specified forest. : @param $CONFIG
 : @param $FOREST_ID
 : @return xs:unsignedLong?
 :)

try {
	admin:forest-get-database($CONFIG, xs:unsignedLong($FOREST_ID))
} catch($error) {
	$error
}