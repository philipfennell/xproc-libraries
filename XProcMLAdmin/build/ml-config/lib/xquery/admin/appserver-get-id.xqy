xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_IDS as xs:string external;
declare variable $APPSERVER_NAME as xs:string external;

(:
 : This function returns the ID of the specified App Server. The difference between this function and xdmp:server() is that the ID from this function can come from an appserver that has not yet been saved (that is, from an appserver that has been created in the same query with the Admin library but has not yet been saved to the cluster configuration files). This ID enables you to completely configure a newly created appserver without the need to first save the configuration. : @param $CONFIG
 : @param $GROUP_IDS
 : @param $APPSERVER_NAME
 : @return xs:unsignedLong*
 :)

try {
	admin:appserver-get-id($CONFIG, xs:unsignedLong($GROUP_IDS), xs:string($APPSERVER_NAME))
} catch($error) {
	$error
}