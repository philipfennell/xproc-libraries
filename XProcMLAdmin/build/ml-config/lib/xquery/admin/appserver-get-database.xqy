xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the ID of the database to which the App Server is set to execute queries against for the specified database. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:unsignedLong
 :)

try {
	admin:appserver-get-database($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}