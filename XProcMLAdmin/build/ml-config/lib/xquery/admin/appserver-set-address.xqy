xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function changes the IP Address in the configuration for the specified App Server to the specified address. Changing the address is a "cold" operation; when you use admin:save-configuration to save the configuration, it will automatically restart MarkLogic Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-address($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:string($VALUE))
} catch($error) {
	$error
}