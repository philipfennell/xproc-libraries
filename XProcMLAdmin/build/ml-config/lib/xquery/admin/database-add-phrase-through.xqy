xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $PHRASE_THROUGHS as element(db:phrase-through)* := <phrase-throughs/>;

(:
 : This function adds a phrase through to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $PHRASE_THROUGHS
 : @return element(configuration)
 :)

try {
	admin:database-add-phrase-through($CONFIG, xs:unsignedLong($DATABASE_ID), $PHRASE_THROUGHS)
} catch($error) {
	$error
}