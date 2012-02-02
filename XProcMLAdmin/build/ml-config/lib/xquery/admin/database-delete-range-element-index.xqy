xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $RANGE_INDEXES as element(db:range-element-index)* := <range-indexes/>;

(:
 : This function deletes a range element index for the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $RANGE_INDEXES
 : @return element(configuration)
 :)

try {
	admin:database-delete-range-element-index($CONFIG, xs:unsignedLong($DATABASE_ID), $RANGE_INDEXES)
} catch($error) {
	$error
}