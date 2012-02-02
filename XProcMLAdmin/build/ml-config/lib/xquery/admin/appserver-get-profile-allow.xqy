xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the value of the profile allow setting configured for this App Server, where true indicates that the App Server will allow queries to be profiled, and false indicates that it will not. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:boolean
 :)

try {
	admin:appserver-get-profile-allow($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}