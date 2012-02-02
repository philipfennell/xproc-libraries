xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_IDS as xs:string external;

(:
 : This function deletes one or more groups in the configuration. : @param $CONFIG
 : @param $GROUP_IDS
 : @return element(configuration)
 :)

try {
	admin:group-delete($CONFIG, xs:unsignedLong($GROUP_IDS))
} catch($error) {
	$error
}