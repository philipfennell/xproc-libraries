xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $BACKUP_DIR as xs:string external;
declare variable $START as xs:string external;
declare variable $MAX_BACKUPS as xs:string external;
declare variable $BACKUP_SECURITY_DB as xs:string external;
declare variable $BACKUP_SCHEMAS_DB as xs:string external;
declare variable $BACKUP_TRIGGERS_DB as xs:string external;
declare variable $INCLUDE_REPLICAS as xs:string* external;

(:
 : This function constructs a one-time backup. : @param $BACKUP_DIR
 : @param $START
 : @param $MAX_BACKUPS
 : @param $BACKUP_SECURITY_DB
 : @param $BACKUP_SCHEMAS_DB
 : @param $BACKUP_TRIGGERS_DB
 : @param $INCLUDE_REPLICAS
 : @return element(db:database-backup)
 :)

try {
	admin:database-one-time-backup(xs:string($BACKUP_DIR), xs:dateTime($START), xs:unsignedLong($MAX_BACKUPS), xs:boolean($BACKUP_SECURITY_DB), xs:boolean($BACKUP_SCHEMAS_DB), xs:boolean($BACKUP_TRIGGERS_DB), xs:boolean($INCLUDE_REPLICAS))
} catch($error) {
	$error
}