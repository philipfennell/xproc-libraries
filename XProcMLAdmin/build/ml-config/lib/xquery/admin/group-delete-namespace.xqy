xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $NAMESPACES as element(gr:namespace)* := <namespaces/>;

(:
 : This function deletes the specified namespaces from the configuration for the specified group. : @param $CONFIG
 : @param $GROUP_ID
 : @param $NAMESPACES
 : @return element(configuration)
 :)

try {
	admin:group-delete-namespace($CONFIG, xs:unsignedLong($GROUP_ID), $NAMESPACES)
} catch($error) {
	$error
}