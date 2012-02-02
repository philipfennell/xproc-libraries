xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $BACKUP_DIR as xs:string external;
declare variable $BACKUP_PERIOD as xs:string external;

(:
 : This function constructs a scheduled forest backup on a number-of-minutes basis. : @param $BACKUP_DIR
 : @param $BACKUP_PERIOD
 : @return element(as:forest-backup)
 :)

try {
	admin:forest-minutely-backup(xs:string($BACKUP_DIR), xs:positiveInteger($BACKUP_PERIOD))
} catch($error) {
	$error
}