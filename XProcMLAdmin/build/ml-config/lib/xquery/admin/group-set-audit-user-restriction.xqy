xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $RESTRICTION_TYPE as xs:string external;
declare variable $USERS as xs:string external;

(:
 : This function restricts the audit configuration by excluding or including by user. : @param $CONFIG
 : @param $GROUP_ID
 : @param $RESTRICTION_TYPE
 : @param $USERS
 : @return element(configuration)
 :)

try {
	admin:group-set-audit-user-restriction($CONFIG, xs:unsignedLong($GROUP_ID), xs:string($RESTRICTION_TYPE), xs:string($USERS))
} catch($error) {
	$error
}