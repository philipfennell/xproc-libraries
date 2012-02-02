xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;
declare variable $HOSTS as xs:string external;

(:
 : This function deletes the specified failover host(s) from the failover-host list in the specified configuration. : @param $CONFIG
 : @param $FOREST_ID
 : @param $HOSTS
 : @return element(configuration)
 :)

try {
	admin:forest-delete-failover-host($CONFIG, xs:unsignedLong($FOREST_ID), xs:unsignedLong($HOSTS))
} catch($error) {
	$error
}