xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $SCHEMAS as element(gr:schema)* := <schemas/>;

(:
 : This function deletes a schema definition in the configuration for the specified App Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $SCHEMAS
 : @return element(configuration)
 :)

try {
	admin:appserver-delete-schema($CONFIG, xs:unsignedLong($APPSERVER_ID), $SCHEMAS)
} catch($error) {
	$error
}