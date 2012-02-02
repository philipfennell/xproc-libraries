xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FIELD_NAMES as xs:string external;

(:
 : This function deletes the field specification in the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FIELD_NAMES
 : @return element(configuration)
 :)

try {
	admin:database-delete-field($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($FIELD_NAMES))
} catch($error) {
	$error
}