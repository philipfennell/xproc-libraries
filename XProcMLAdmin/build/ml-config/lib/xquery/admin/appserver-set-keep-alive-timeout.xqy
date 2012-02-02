xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the keep-alive timeout (the maximum number of second for subsequent socket requests to time out) in the configuration for the specified App Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-keep-alive-timeout($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:unsignedInt($VALUE))
} catch($error) {
	$error
}