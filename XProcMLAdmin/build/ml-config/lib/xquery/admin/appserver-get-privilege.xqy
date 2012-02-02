xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the privilege ID for the specified App Server. If no privilege is configured, It returns 0. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:unsignedLong
 :)

try {
	admin:appserver-get-privilege($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}