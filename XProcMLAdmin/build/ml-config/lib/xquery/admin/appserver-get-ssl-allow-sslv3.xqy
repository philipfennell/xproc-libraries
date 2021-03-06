xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns true if the SSL v3 protocol is enabled for the specified App Server, or false if SSL v3 is disabled. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:boolean
 :)

try {
	admin:appserver-get-ssl-allow-sslv3($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}