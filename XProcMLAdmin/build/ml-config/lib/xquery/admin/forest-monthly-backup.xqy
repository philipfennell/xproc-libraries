xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $BACKUP_DIR as xs:string external;
declare variable $BACKUP_PERIOD as xs:string external;
declare variable $BACKUP_MONTH_DAY as xs:string external;
declare variable $START_TIME as xs:string external;

(:
 : This function constructs a monthly scheduled backup. : @param $BACKUP_DIR
 : @param $BACKUP_PERIOD
 : @param $BACKUP_MONTH_DAY
 : @param $START_TIME
 : @return element(as:forest-backup)
 :)

try {
	admin:forest-monthly-backup(xs:string($BACKUP_DIR), xs:positiveInteger($BACKUP_PERIOD), xs:unsignedInt($BACKUP_MONTH_DAY), xs:time($START_TIME))
} catch($error) {
	$error
}