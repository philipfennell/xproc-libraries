xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns the value for the compressed tree cache partitions setting from the specified group. : @param $CONFIG
 : @param $GROUP_ID
 : @return xs:unsignedInt
 :)

try {
	admin:group-get-compressed-tree-cache-partitions($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}