xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_NAME as xs:string external;

(:
 : This function returns the ID of the group. The difference between this function and xdmp:group() is that the ID from this function can come from a group that has not yet been saved (that is, from a group that has been created in the same query with the Admin library but has not yet been saved to the cluster configuration files). This ID enables you to completely configure a newly created group without the need to first save the configuration. : @param $CONFIG
 : @param $GROUP_NAME
 : @return xs:unsignedLong
 :)

try {
	admin:group-get-id($CONFIG, xs:string($GROUP_NAME))
} catch($error) {
	$error
}