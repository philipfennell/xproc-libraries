xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $EVENT_TYPE as xs:string external;

(:
 : This function returns the audit event type's enabled setting for the audit configuration. A value of true is returned is the specified event type is set. Otherwise false is returned. : @param $CONFIG
 : @param $GROUP_ID
 : @param $EVENT_TYPE
 : @return xs:boolean
 :)

try {
	admin:group-get-audit-event-type-enabled($CONFIG, xs:unsignedLong($GROUP_ID), xs:string($EVENT_TYPE))
} catch($error) {
	$error
}