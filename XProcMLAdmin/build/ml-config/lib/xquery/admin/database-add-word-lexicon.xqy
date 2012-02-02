xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $WORD_LEXICONS as element(db:word-lexicon)* := <word-lexicons/>;

(:
 : This function adds a word lexicon to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $WORD_LEXICONS
 : @return element(configuration)
 :)

try {
	admin:database-add-word-lexicon($CONFIG, xs:unsignedLong($DATABASE_ID), $WORD_LEXICONS)
} catch($error) {
	$error
}