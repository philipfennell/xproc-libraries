xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the SSL hostname for the specified App Server. If no hostname is set, nothing is returned. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:string?
 :)

try {
	admin:appserver-get-ssl-hostname($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}