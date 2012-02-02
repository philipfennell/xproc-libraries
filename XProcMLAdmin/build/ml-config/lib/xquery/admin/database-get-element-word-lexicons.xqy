xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function returns the element word lexicons specification(s) for the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @return element(db:element-word-lexicon)*
 :)

try {
	admin:database-get-element-word-lexicons($CONFIG, xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}