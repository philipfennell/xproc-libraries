xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function returns the index detection setting for the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @return xs:string
 :)

try {
	admin:database-get-index-detection($CONFIG, xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}