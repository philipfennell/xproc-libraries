xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $BLACKOUTS as element(db:merge-blackout)* := <blackouts/>;

(:
 : This function deletes a merge blackout specification for a database from a configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $BLACKOUTS
 : @return element(configuration)
 :)

try {
	admin:database-delete-merge-blackout($CONFIG, xs:unsignedLong($DATABASE_ID), $BLACKOUTS)
} catch($error) {
	$error
}