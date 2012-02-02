xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $BACKUPS as element(db:database-backup)* := <backups/>;

(:
 : This function adds scheduled backup specifications for a database to a configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $BACKUPS
 : @return element(configuration)
 :)

try {
	admin:database-add-backup($CONFIG, xs:unsignedLong($DATABASE_ID), $BACKUPS)
} catch($error) {
	$error
}