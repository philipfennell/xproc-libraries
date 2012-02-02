xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $LEXICONS as element(db:element-attribute-word-lexicon)* := <lexicons/>;

(:
 : This function deletes an element attribute word lexicon for the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $LEXICONS
 : @return element(configuration)
 :)

try {
	admin:database-delete-element-attribute-word-lexicon($CONFIG, xs:unsignedLong($DATABASE_ID), $LEXICONS)
} catch($error) {
	$error
}