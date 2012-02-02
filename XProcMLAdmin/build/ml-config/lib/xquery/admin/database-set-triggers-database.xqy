xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the triggers database to the specified database ID for the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:database-set-triggers-database($CONFIG, xs:unsignedLong($DATABASE_ID), xs:unsignedLong($VALUE))
} catch($error) {
	$error
}