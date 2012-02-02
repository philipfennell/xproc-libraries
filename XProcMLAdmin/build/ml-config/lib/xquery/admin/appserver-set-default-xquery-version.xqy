xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the default XQuery version setting in the configuration for this App Server. This setting determines the XQuery dialect used in queries against this App Server when one is not explicitly specified in the XQuery version declaration. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-default-xquery-version($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:string($VALUE))
} catch($error) {
	$error
}