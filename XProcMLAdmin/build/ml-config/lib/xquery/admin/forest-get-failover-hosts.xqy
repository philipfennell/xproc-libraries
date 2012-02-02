xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;

(:
 : This function returns the forest IDs of the hosts defined as failover hosts for this forest. The order in which the hosts IDs are returned is significant, with the first ID being the primary host, the second (if there is one) being the secondary, and so on. : @param $CONFIG
 : @param $FOREST_ID
 : @return xs:unsignedLong*
 :)

try {
	admin:forest-get-failover-hosts($CONFIG, xs:unsignedLong($FOREST_ID))
} catch($error) {
	$error
}