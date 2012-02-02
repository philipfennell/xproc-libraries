xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $NAMESPACES as element(gr:namespace)* := <namespaces/>;

(:
 : This function deletes a namespace configuration from the configuration for the specified App Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $NAMESPACES
 : @return element(configuration)
 :)

try {
	admin:appserver-delete-namespace($CONFIG, xs:unsignedLong($APPSERVER_ID), $NAMESPACES)
} catch($error) {
	$error
}