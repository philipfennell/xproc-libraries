xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns the IDs of all appservers belonging to the group. : @param $CONFIG
 : @param $GROUP_ID
 : @return xs:unsignedLong*
 :)

try {
	admin:group-get-appserver-ids($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}