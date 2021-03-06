xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns the users included from auditing. If auditing has a "exclusion" restriction, this function returns the empty sequence. : @param $CONFIG
 : @param $GROUP_ID
 : @return xs:unsignedLong*
 :)

try {
	admin:group-get-audit-included-users($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}