xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the session timeout value (in seconds) in the configuration for the specified App Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-session-timeout($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:unsignedInt($VALUE))
} catch($error) {
	$error
}