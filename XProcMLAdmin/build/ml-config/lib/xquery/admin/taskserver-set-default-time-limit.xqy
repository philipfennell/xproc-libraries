xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the task server default time limit in the configuration. : @param $CONFIG
 : @param $GROUP_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:taskserver-set-default-time-limit($CONFIG, xs:unsignedLong($GROUP_ID), xs:unsignedInt($VALUE))
} catch($error) {
	$error
}