xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FOREST_ID as xs:string external;

(:
 : This function detaches the specified forest from the specified database. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FOREST_ID
 : @return element(configuration)
 :)

try {
	admin:database-detach-forest($CONFIG, xs:unsignedLong($DATABASE_ID), xs:unsignedLong($FOREST_ID))
} catch($error) {
	$error
}