xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $MERGE_BLACKOUTS as element(db:merge-blackout)* := <merge-blackouts/>;

(:
 : This function adds a merge blackout specification for a database to a configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $MERGE_BLACKOUTS
 : @return element(configuration)
 :)

try {
	admin:database-add-merge-blackout($CONFIG, xs:unsignedLong($DATABASE_ID), $MERGE_BLACKOUTS)
} catch($error) {
	$error
}