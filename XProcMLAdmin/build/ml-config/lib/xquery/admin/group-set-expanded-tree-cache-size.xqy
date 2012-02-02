xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function changes the expanded tree cache size setting of the group with the specified ID to the specified value. : @param $CONFIG
 : @param $GROUP_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:group-set-expanded-tree-cache-size($CONFIG, xs:unsignedLong($GROUP_ID), xs:unsignedInt($VALUE))
} catch($error) {
	$error
}