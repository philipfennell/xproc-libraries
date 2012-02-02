xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;
declare variable $BACKUPS as element(as:forest-backup)* := <backups/>;

(:
 : This function deletes scheduled backup specifications for a forest from a configuration. : @param $CONFIG
 : @param $FOREST_ID
 : @param $BACKUPS
 : @return element(configuration)
 :)

try {
	admin:forest-delete-backup($CONFIG, xs:unsignedLong($FOREST_ID), $BACKUPS)
} catch($error) {
	$error
}