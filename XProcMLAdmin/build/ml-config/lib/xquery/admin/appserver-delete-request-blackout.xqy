xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $BLACKOUTS as element(gr:request-blackout)* := <blackouts/>;

(:
 : This function deletes a request blackout specification for a appserver from a configuration. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $BLACKOUTS
 : @return element(configuration)
 :)

try {
	admin:appserver-delete-request-blackout($CONFIG, xs:unsignedLong($APPSERVER_ID), $BLACKOUTS)
} catch($error) {
	$error
}