xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function changes the name of the database with the specified ID to the specified name. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:database-set-name($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($VALUE))
} catch($error) {
	$error
}