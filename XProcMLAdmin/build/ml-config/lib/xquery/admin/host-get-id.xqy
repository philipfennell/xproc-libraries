xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $HOST_NAME as xs:string external;

(:
 : This function return the ID for the specified host from the configuration. The difference between this function and xdmp:host() is that the ID from this function can come from a host that has not yet been saved (that is, from a host that has been created in the same query with the Admin library but has not yet been saved to the cluster configuration files). This ID enables you to completely configure a newly created host without the need to first save the configuration. : @param $CONFIG
 : @param $HOST_NAME
 : @return xs:unsignedLong
 :)

try {
	admin:host-get-id($CONFIG, xs:string($HOST_NAME))
} catch($error) {
	$error
}