xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets a forest configuration to a new host. : @param $CONFIG
 : @param $FOREST_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:forest-set-host($CONFIG, xs:unsignedLong($FOREST_ID), xs:unsignedLong($VALUE))
} catch($error) {
	$error
}