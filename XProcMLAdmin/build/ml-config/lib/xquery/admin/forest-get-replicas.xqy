xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;

(:
 : This function returns the IDs of the forest replicas for the specified forest. If it returns the empty sequence, then no replacas are assigned to the specified forest. : @param $CONFIG
 : @param $FOREST_ID
 : @return xs:unsignedLong*
 :)

try {
	admin:forest-get-replicas($CONFIG, xs:unsignedLong($FOREST_ID))
} catch($error) {
	$error
}