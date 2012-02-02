xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $NAMESPACES as element(gr:namespace)* := <namespaces/>;

(:
 : Add one or more namespaces to a Group configuration, which will predefine the namespace(s) for all requests evaluated against any App Server in the Group. : @param $CONFIG
 : @param $GROUP_ID
 : @param $NAMESPACES
 : @return element(configuration)
 :)

try {
	admin:group-add-namespace($CONFIG, xs:unsignedLong($GROUP_ID), $NAMESPACES)
} catch($error) {
	$error
}