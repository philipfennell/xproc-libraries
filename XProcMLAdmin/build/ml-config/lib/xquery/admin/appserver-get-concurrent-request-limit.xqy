xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the concurrent request limit for any user for the specified App Server. 0 indicates no bound on the number of concurrent requests. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:unsignedInt
 :)

try {
	admin:appserver-get-concurrent-request-limit($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}