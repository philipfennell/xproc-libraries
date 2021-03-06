xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns the value for the rotate log files setting from the specified group. : @param $CONFIG
 : @param $GROUP_ID
 : @return xs:string
 :)

try {
	admin:group-get-rotate-log-files($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}