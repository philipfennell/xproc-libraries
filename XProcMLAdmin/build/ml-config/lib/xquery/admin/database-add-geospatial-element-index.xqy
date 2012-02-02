xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $GEOSPATIAL_ELEMENT_INDEXES as element(db:geospatial-element-index)* := <geospatial-element-indexes/>;

(:
 : This function adds a range element index to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $GEOSPATIAL_ELEMENT_INDEXES
 : @return element(configuration)
 :)

try {
	admin:database-add-geospatial-element-index($CONFIG, xs:unsignedLong($DATABASE_ID), $GEOSPATIAL_ELEMENT_INDEXES)
} catch($error) {
	$error
}