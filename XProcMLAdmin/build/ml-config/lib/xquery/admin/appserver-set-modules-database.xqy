xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the value in the configuration of modules database for the specified App Server to the specified database ID. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-modules-database($CONFIG, xs:unsignedLong($APPSERVER_ID), if (fn:matches($VALUE, '\d+')) then xs:unsignedLong($VALUE) else xs:string($VALUE))
} catch($error) {
	$error
}