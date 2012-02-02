xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $ELEMENT_WORD_QUERY_THROUGHS as element(db:element-word-query-through)* := <element-word-query-throughs/>;

(:
 : This function adds an element word query through to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $ELEMENT_WORD_QUERY_THROUGHS
 : @return element(configuration)
 :)

try {
	admin:database-add-element-word-query-through($CONFIG, xs:unsignedLong($DATABASE_ID), $ELEMENT_WORD_QUERY_THROUGHS)
} catch($error) {
	$error
}