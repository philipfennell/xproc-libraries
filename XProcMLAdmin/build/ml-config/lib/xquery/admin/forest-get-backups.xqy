xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;

(:
 : This function returns the scheduled backups for the specified forest from the configuration. : @param $CONFIG
 : @param $FOREST_ID
 : @return element(as:forest-backup)*
 :)

try {
	admin:forest-get-backups($CONFIG, xs:unsignedLong($FOREST_ID))
} catch($error) {
	$error
}