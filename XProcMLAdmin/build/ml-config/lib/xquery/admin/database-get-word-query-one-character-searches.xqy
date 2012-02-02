xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function returns true if the word query one character searches setting is enabled for the specified database in the configuration. Otherwise, it returns the empty sequence. : @param $CONFIG
 : @param $DATABASE_ID
 : @return xs:boolean?
 :)

try {
	admin:database-get-word-query-one-character-searches($CONFIG, xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}