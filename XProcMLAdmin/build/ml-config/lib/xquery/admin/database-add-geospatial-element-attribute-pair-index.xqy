xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $GEOSPATIAL_ELEMENT_ATTRIBUTE_PAIR_INDEXES as element(db:geospatial-element-attribute-pair-index)* := <geospatial-element-attribute-pair-indexes/>;

(:
 : This function adds a geospatial element attribute pair index to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $GEOSPATIAL_ELEMENT_ATTRIBUTE_PAIR_INDEXES
 : @return element(configuration)
 :)

try {
	admin:database-add-geospatial-element-attribute-pair-index($CONFIG, xs:unsignedLong($DATABASE_ID), $GEOSPATIAL_ELEMENT_ATTRIBUTE_PAIR_INDEXES)
} catch($error) {
	$error
}