xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;

(:
 : This function returns the path to the URL rewriter configured for this App Server. If no URL rewriter is configured, returns the empty string. : @param $CONFIG
 : @param $APPSERVER_ID
 : @return xs:string
 :)

try {
	admin:appserver-get-url-rewriter($CONFIG, xs:unsignedLong($APPSERVER_ID))
} catch($error) {
	$error
}