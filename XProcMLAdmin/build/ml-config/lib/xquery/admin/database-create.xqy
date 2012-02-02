xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_NAME as xs:string external;
declare variable $SECURITY_DB as xs:string external;
declare variable $SCHEMA_DB as xs:string external;

(:
 : This function creates a new database specification. : @param $CONFIG
 : @param $DATABASE_NAME
 : @param $SECURITY_DB
 : @param $SCHEMA_DB
 : @return element(configuration)
 :)

try {
	admin:database-create($CONFIG, xs:string($DATABASE_NAME), xs:unsignedLong($SECURITY_DB), xs:unsignedLong($SCHEMA_DB))
} catch($error) {
	$error
}