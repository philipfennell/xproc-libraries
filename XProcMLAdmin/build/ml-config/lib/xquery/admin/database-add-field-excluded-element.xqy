xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FIELD_NAME as xs:string external;
declare variable $EXCLUDED_ELEMENTS as element(db:excluded-element)* := <excluded-elements/>;

(:
 : This function adds the field excluded element specification in the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FIELD_NAME
 : @param $EXCLUDED_ELEMENTS
 : @return element(configuration)
 :)

try {
	admin:database-add-field-excluded-element($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($FIELD_NAME), $EXCLUDED_ELEMENTS)
} catch($error) {
	$error
}