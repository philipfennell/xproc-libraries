xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns all of the tasks scheduled for the specified group. : @param $CONFIG
 : @param $GROUP_ID
 : @return element(gr:scheduled-task)*
 :)

try {
	admin:group-get-scheduled-tasks($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}