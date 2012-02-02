xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function changes the failover enable setting for the group in the configuration. : @param $CONFIG
 : @param $GROUP_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:group-set-failover-enable($CONFIG, xs:unsignedLong($GROUP_ID), xs:boolean($VALUE))
} catch($error) {
	$error
}