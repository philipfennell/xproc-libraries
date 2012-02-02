xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function changes the host initial timeout setting (the time the cluster will wait for a host to come online during cluster startup) for the group in the configuration. : @param $CONFIG
 : @param $GROUP_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:group-set-host-initial-timeout($CONFIG, xs:unsignedLong($GROUP_ID), xs:unsignedInt($VALUE))
} catch($error) {
	$error
}