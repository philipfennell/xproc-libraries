xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $PHRASE_AROUNDS as element(db:phrase-around)* := <phrase-arounds/>;

(:
 : This function deletes a phrase around for the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $PHRASE_AROUNDS
 : @return element(configuration)
 :)

try {
	admin:database-delete-phrase-around($CONFIG, xs:unsignedLong($DATABASE_ID), $PHRASE_AROUNDS)
} catch($error) {
	$error
}