xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $ATTRIBUTE_INDEXES as element(db:range-element-attribute-index)* := <attribute-indexes/>;

(:
 : This function deletes a range element attribute index for the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $ATTRIBUTE_INDEXES
 : @return element(configuration)
 :)

try {
	admin:database-delete-range-element-attribute-index($CONFIG, xs:unsignedLong($DATABASE_ID), $ATTRIBUTE_INDEXES)
} catch($error) {
	$error
}