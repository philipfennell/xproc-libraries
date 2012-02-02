xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $BACKUP_DIR as xs:string external;
declare variable $START as xs:string external;

(:
 : This function constructs a one-time backup. : @param $BACKUP_DIR
 : @param $START
 : @return element(as:forest-backup)
 :)

try {
	admin:forest-one-time-backup(xs:string($BACKUP_DIR), xs:dateTime($START))
} catch($error) {
	$error
}