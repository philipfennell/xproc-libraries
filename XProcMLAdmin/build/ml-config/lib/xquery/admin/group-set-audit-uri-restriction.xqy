xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $RESTRICTION_TYPE as xs:string external;
declare variable $URIS as xs:string external;

(:
 : This function restricts the audit configuration by excluding or including by document uri(s). : @param $CONFIG
 : @param $GROUP_ID
 : @param $RESTRICTION_TYPE
 : @param $URIS
 : @return element(configuration)
 :)

try {
	admin:group-set-audit-uri-restriction($CONFIG, xs:unsignedLong($GROUP_ID), xs:string($RESTRICTION_TYPE), xs:string($URIS))
} catch($error) {
	$error
}