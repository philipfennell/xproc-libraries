xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the value in the configuration of the last login database for the specified App Server. If the value is equal to 0, then the last-login feature is disabled for this appserver. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-last-login($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:unsignedLong($VALUE))
} catch($error) {
	$error
}