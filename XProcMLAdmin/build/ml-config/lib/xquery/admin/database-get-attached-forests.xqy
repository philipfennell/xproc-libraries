xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function returns the attached forest IDs for the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @return xs:unsignedLong*
 :)

try {
	admin:database-get-attached-forests($CONFIG, xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}