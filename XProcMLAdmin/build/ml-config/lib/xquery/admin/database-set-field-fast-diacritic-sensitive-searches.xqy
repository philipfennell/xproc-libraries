xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FIELD_NAME as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the field fast diacritic sensitive searches setting for the specified field in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FIELD_NAME
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:database-set-field-fast-diacritic-sensitive-searches($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($FIELD_NAME), xs:boolean($VALUE))
} catch($error) {
	$error
}