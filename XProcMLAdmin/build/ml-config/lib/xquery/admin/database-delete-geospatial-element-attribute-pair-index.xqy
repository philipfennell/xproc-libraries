xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $INDEXES as element(db:geospatial-element-attribute-pair-index)* := <indexes/>;

(:
 : This function deletes a geospatial element attribute pair index in the specified database from the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $INDEXES
 : @return element(configuration)
 :)

try {
	admin:database-delete-geospatial-element-attribute-pair-index($CONFIG, xs:unsignedLong($DATABASE_ID), $INDEXES)
} catch($error) {
	$error
}