xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $REQUEST_BLACKOUTS as element(gr:request-blackout)* := <request-blackouts/>;

(:
 : This function adds a request blackout specification for a appserver to a configuration. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $REQUEST_BLACKOUTS
 : @return element(configuration)
 :)

try {
	admin:appserver-add-request-blackout($CONFIG, xs:unsignedLong($APPSERVER_ID), $REQUEST_BLACKOUTS)
} catch($error) {
	$error
}