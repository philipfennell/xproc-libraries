xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the value of the "expires" HTTP header for static content to expire after this many seconds port for the specified App Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:unsignedInt
 :)

try {
	admin:appserver-get-static-expires($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}