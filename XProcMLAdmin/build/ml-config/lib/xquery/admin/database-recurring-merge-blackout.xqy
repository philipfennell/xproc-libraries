xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $LIMIT as xs:string external;
declare variable $MERGE_PRIORITY as xs:string external;
declare variable $DAYS as xs:string external;
declare variable $START_TIME as xs:string external;
declare variable $END_TIME as xs:string external;
declare variable $DURATION as xs:string external;

(:
 : This function constructs a merge-blackout specification. : @param $LIMIT
 : @param $MERGE_PRIORITY
 : @param $DAYS
 : @param $START_TIME
 : @param $END_TIME
 : @param $DURATION
 : @return element(db:merge-blackout)
 :)

try {
	admin:database-recurring-merge-blackout(xs:unsignedInt($LIMIT), xs:string($MERGE_PRIORITY), xs:string($DAYS), xs:time($START_TIME), xs:time($END_TIME), xs:duration($DURATION))
} catch($error) {
	$error
}