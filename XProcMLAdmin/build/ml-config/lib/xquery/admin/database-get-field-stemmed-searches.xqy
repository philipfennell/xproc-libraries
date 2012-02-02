xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FIELD_NAME as xs:string external;

(:
 : This function returns stemmed searches setting for the specified field if configured. Otherwise, it returns the empty sequence. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FIELD_NAME
 : @return xs:string?
 :)

try {
	admin:database-get-field-stemmed-searches($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($FIELD_NAME))
} catch($error) {
	$error
}