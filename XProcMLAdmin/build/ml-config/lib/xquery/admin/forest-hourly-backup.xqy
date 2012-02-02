xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $BACKUP_DIR as xs:string external;
declare variable $BACKUP_PERIOD as xs:string external;
declare variable $START_MINUTE as xs:string external;

(:
 : This function constructs a hourly scheduled forest backup. : @param $BACKUP_DIR
 : @param $BACKUP_PERIOD
 : @param $START_MINUTE
 : @return element(as:forest-backup)
 :)

try {
	admin:forest-hourly-backup(xs:string($BACKUP_DIR), xs:positiveInteger($BACKUP_PERIOD), xs:nonNegativeInteger($START_MINUTE))
} catch($error) {
	$error
}