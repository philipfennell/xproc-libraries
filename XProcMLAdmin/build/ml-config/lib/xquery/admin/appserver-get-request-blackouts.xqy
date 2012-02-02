xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the request blackouts specification for the specified appserver from the configuration. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return element(gr:request-blackout)*
 :)

try {
	admin:appserver-get-request-blackouts($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}