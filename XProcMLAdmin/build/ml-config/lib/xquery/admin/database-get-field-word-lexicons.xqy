xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FIELD_NAME as xs:string external;

(:
 : This function returns the word lexicons specification(s) for the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FIELD_NAME
 : @return element(db:word-lexicon)*
 :)

try {
	admin:database-get-field-word-lexicons($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($FIELD_NAME))
} catch($error) {
	$error
}