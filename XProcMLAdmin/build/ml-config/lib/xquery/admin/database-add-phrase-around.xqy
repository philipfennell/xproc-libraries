xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $PHRASE_AROUNDS as element(db:phrase-around)* := <phrase-arounds/>;

(:
 : This function adds a phrase around to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $PHRASE_AROUNDS
 : @return element(configuration)
 :)

try {
	admin:database-add-phrase-around($CONFIG, xs:unsignedLong($DATABASE_ID), $PHRASE_AROUNDS)
} catch($error) {
	$error
}