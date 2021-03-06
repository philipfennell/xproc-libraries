xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $EXCLUDED_ELEMENTS as element(db:excluded-element)* := <excluded-elements/>;

(:
 : This function deletes the word query excluded element specification in the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $EXCLUDED_ELEMENTS
 : @return element(configuration)
 :)

try {
	admin:database-delete-word-query-excluded-element($CONFIG, xs:unsignedLong($DATABASE_ID), $EXCLUDED_ELEMENTS)
} catch($error) {
	$error
}