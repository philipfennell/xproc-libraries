xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $THROUGHS as element(db:element-word-query-through)* := <throughs/>;

(:
 : This function deletes an element word query through for the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $THROUGHS
 : @return element(configuration)
 :)

try {
	admin:database-delete-element-word-query-through($CONFIG, xs:unsignedLong($DATABASE_ID), $THROUGHS)
} catch($error) {
	$error
}