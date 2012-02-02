xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $GROUP_NAME as xs:string external;

(:
 : This function creates a new group specification with the same settings as the group with the specified ID. The new group configuration will have the specified name. : @param $CONFIG
 : @param $GROUP_ID
 : @param $GROUP_NAME
 : @return element(configuration)
 :)

try {
	admin:group-copy($CONFIG, xs:unsignedLong($GROUP_ID), xs:string($GROUP_NAME))
} catch($error) {
	$error
}