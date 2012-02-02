xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the type of appserver with the specified ID. It will be either "http", "xdbc", or "WebDAV". : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:string
 :)

try {
	admin:appserver-get-type($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}