xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $USERS as xs:string external;
declare variable $ROLES as xs:string external;
declare variable $DAYS as xs:string external;
declare variable $START_TIME as xs:string external;
declare variable $END_TIME as xs:string external;
declare variable $DURATION as xs:string external;

(:
 : This function constructs a request-blackout specification. : @param $USERS
 : @param $ROLES
 : @param $DAYS
 : @param $START_TIME
 : @param $END_TIME
 : @param $DURATION
 : @return element(gr:request-blackout)
 :)

try {
	admin:appserver-recurring-request-blackout(xs:unsignedLong($USERS), xs:unsignedLong($ROLES), xs:string($DAYS), xs:time($START_TIME), xs:time($END_TIME), xs:duration($DURATION))
} catch($error) {
	$error
}