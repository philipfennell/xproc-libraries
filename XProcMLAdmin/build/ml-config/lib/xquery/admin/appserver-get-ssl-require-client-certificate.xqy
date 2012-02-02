xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns true if a client certificate is required for the specified App Server. Otherwise, it returns false. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:boolean
 :)

try {
	admin:appserver-get-ssl-require-client-certificate($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}