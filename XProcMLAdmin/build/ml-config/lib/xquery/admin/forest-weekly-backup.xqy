xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $BACKUP_DIR as xs:string external;
declare variable $BACKUP_PERIOD as xs:string external;
declare variable $DAYS as xs:string external;
declare variable $START_TIME as xs:string external;

(:
 : This function constructs a weekly scheduled backup. : @param $BACKUP_DIR
 : @param $BACKUP_PERIOD
 : @param $DAYS
 : @param $START_TIME
 : @return element(as:forest-backup)
 :)

try {
	admin:forest-weekly-backup(xs:string($BACKUP_DIR), xs:positiveInteger($BACKUP_PERIOD), xs:string($DAYS), xs:time($START_TIME))
} catch($error) {
	$error
}