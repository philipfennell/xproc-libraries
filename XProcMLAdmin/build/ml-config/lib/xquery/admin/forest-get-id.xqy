xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_NAME as xs:string external;

(:
 : This function returns the ID of the forest with the specified name, from the specified configuration. The difference between this function and xdmp:forest() is that the ID from this function can come from a forest that has not yet been saved (that is, from a forest that has been created in the same query with the Admin library but has not yet been saved to the cluster configuration files). : @param $CONFIG
 : @param $FOREST_NAME
 : @return xs:unsignedLong
 :)

try {
	admin:forest-get-id($CONFIG, xs:string($FOREST_NAME))
} catch($error) {
	$error
}