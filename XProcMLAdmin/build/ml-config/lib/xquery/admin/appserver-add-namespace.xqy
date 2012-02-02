xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $NAMESPACES as element(gr:namespace)* := <namespaces/>;

(:
 : Add one or more namespaces to an App Server configuration, which will predefine the namespace(s) for all requests evaluated against the App Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $NAMESPACES
 : @return element(configuration)
 :)

try {
	admin:appserver-add-namespace($CONFIG, xs:unsignedLong($APPSERVER_ID), $NAMESPACES)
} catch($error) {
	$error
}