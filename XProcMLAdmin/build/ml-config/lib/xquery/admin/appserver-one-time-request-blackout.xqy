xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $USERS as xs:string external;
declare variable $ROLES as xs:string external;
declare variable $START as xs:string external;
declare variable $END as xs:string external;
declare variable $DURATION as xs:string external;

(:
 : This function constructs a one-time request-blackout specification. : @param $USERS
 : @param $ROLES
 : @param $START
 : @param $END
 : @param $DURATION
 : @return element(gr:request-blackout)
 :)

try {
	admin:appserver-one-time-request-blackout(xs:unsignedLong($USERS), xs:unsignedLong($ROLES), xs:dateTime($START), xs:dateTime($END), xs:duration($DURATION))
} catch($error) {
	$error
}