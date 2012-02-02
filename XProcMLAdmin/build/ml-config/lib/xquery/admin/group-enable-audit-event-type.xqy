xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $EVENT_TYPE as xs:string external;

(:
 : This function changes the audit event type(s) enabled setting for the audit configuration. : @param $CONFIG
 : @param $GROUP_ID
 : @param $EVENT_TYPE
 : @return element(configuration)
 :)

try {
	admin:group-enable-audit-event-type($CONFIG, xs:unsignedLong($GROUP_ID), xs:string($EVENT_TYPE))
} catch($error) {
	$error
}