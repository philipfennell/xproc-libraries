xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $OUTCOME as xs:string external;

(:
 : This function restricts the audit configuration by auditing events only if they are "success" or "failure" events. : @param $CONFIG
 : @param $GROUP_ID
 : @param $OUTCOME
 : @return element(configuration)
 :)

try {
	admin:group-set-audit-outcome-restriction($CONFIG, xs:unsignedLong($GROUP_ID), xs:string($OUTCOME))
} catch($error) {
	$error
}