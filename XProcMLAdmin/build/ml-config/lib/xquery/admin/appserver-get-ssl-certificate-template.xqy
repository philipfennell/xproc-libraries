xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the id of the SSL certificate template used by the specified App Server. If no template is set for the App Server, 0 is returned. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:unsignedLong
 :)

try {
	admin:appserver-get-ssl-certificate-template($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}