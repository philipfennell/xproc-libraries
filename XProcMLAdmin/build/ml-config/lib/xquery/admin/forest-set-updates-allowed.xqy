xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the updates-allowed state for a forest configuration. : @param $CONFIG
 : @param $FOREST_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:forest-set-updates-allowed($CONFIG, xs:unsignedLong($FOREST_ID), xs:string($VALUE))
} catch($error) {
	$error
}