xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_IDS as xs:string external;

(:
 : This function deletes one or more App Servers in the configuration. : @param $CONFIG
 : @param $APPSERVER_IDS
 : @return element(configuration)
 :)

try {
	admin:appserver-delete($CONFIG, xs:unsignedLong($APPSERVER_IDS))
} catch($error) {
	$error
}