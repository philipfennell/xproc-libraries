xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns the value of any namespace definitions predefined for the specified group. If none are defined, returns the empty sequence. : @param $CONFIG
 : @param $GROUP_ID
 : @return element(gr:namespace)*
 :)

try {
	admin:group-get-namespaces($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}