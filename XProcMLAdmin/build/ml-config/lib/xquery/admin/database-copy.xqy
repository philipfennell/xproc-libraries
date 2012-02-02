xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $DATABASE_NAME as xs:string external;

(:
 : This function creates a new database specification with the same settings as the database with the specified ID. The new database configuration will have the specified name. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $DATABASE_NAME
 : @return element(configuration)
 :)

try {
	admin:database-copy($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($DATABASE_NAME))
} catch($error) {
	$error
}