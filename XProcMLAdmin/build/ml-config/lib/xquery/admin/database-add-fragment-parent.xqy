xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FRAGMENT_PARENTS as element(db:fragment-parent)* := <fragment-parents/>;

(:
 : This function adds the specified fragment parent to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FRAGMENT_PARENTS
 : @return element(configuration)
 :)

try {
	admin:database-add-fragment-parent($CONFIG, xs:unsignedLong($DATABASE_ID), $FRAGMENT_PARENTS)
} catch($error) {
	$error
}