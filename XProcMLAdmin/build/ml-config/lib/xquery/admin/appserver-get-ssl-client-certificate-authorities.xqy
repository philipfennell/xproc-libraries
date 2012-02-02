xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the id(s) of the client certificate authority for the specified App Server. If no client certificate authority is set, this function returns an empty sequence. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:unsignedLong*
 :)

try {
	admin:appserver-get-ssl-client-certificate-authorities($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}