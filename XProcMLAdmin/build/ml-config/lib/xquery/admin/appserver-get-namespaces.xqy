xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the value of any namespace definitions predefined for the specified App Server. If none are defined, returns the empty sequence. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return element(gr:namespace)*
 :)

try {
	admin:appserver-get-namespaces($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}