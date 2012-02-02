xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $INCLUDED_ELEMENTS as element(db:included-element)* := <included-elements/>;

(:
 : This function adds the word query included element specification to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $INCLUDED_ELEMENTS
 : @return element(configuration)
 :)

try {
	admin:database-add-word-query-included-element($CONFIG, xs:unsignedLong($DATABASE_ID), $INCLUDED_ELEMENTS)
} catch($error) {
	$error
}