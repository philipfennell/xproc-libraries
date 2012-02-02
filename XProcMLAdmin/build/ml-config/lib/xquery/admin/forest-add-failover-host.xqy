xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;
declare variable $HOSTS as xs:string external;

(:
 : This function adds a failover host to the list of failover hosts for the specified forest in the specified configuration. If there are already any hosts specified, this host is added to the end of the list of failover hosts. : @param $CONFIG
 : @param $FOREST_ID
 : @param $HOSTS
 : @return element(configuration)
 :)

try {
	admin:forest-add-failover-host($CONFIG, xs:unsignedLong($FOREST_ID), xs:unsignedLong($HOSTS))
} catch($error) {
	$error
}