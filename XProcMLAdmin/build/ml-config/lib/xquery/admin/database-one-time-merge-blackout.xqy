xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $LIMIT as xs:string external;
declare variable $MERGE_PRIORITY as xs:string external;
declare variable $START as xs:string external;
declare variable $END as xs:string external;
declare variable $DURATION as xs:string external;

(:
 : This function constructs a one-time merge-blackout specification. : @param $LIMIT
 : @param $MERGE_PRIORITY
 : @param $START
 : @param $END
 : @param $DURATION
 : @return element(db:merge-blackout)
 :)

try {
	admin:database-one-time-merge-blackout(xs:unsignedInt($LIMIT), xs:string($MERGE_PRIORITY), xs:dateTime($START), xs:dateTime($END), xs:duration($DURATION))
} catch($error) {
	$error
}