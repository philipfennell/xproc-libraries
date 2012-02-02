xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FIELD_NAME as xs:string external;
declare variable $INCLUDED_ELEMENTS as element(db:included-element)* := <included-elements/>;

(:
 : This function deletes the field included element specification in the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FIELD_NAME
 : @param $INCLUDED_ELEMENTS
 : @return element(configuration)
 :)

try {
	admin:database-delete-field-included-element($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($FIELD_NAME), $INCLUDED_ELEMENTS)
} catch($error) {
	$error
}