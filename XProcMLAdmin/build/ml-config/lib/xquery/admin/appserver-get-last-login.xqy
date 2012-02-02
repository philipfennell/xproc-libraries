xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the ID of the database to which the App Server stores users' last login information. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:unsignedLong
 :)

try {
	admin:appserver-get-last-login($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}