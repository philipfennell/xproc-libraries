xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_IDS as xs:string external;
declare variable $APPSERVER_NAME as xs:string external;

(:
 : This function determines whether or not the specified App Server exists. Returns true if the App Server exists, otherwise false is returned. : @param $CONFIG
 : @param $GROUP_IDS
 : @param $APPSERVER_NAME
 : @return xs:boolean
 :)

try {
	admin:appserver-exists($CONFIG, xs:unsignedLong($GROUP_IDS), xs:string($APPSERVER_NAME))
} catch($error) {
	$error
}