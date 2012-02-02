xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_IDS as xs:string external;

(:
 : This function deletes the configuration from the specified database(s). It does not delete the configuration or data for any forests attached to the deleted database(s). : @param $CONFIG
 : @param $DATABASE_IDS
 : @return element(configuration)
 :)

try {
	admin:database-delete($CONFIG, xs:unsignedLong($DATABASE_IDS))
} catch($error) {
	$error
}