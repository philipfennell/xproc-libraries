xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $SCHEMAS as element(gr:schema)* := <schemas/>;

(:
 : This function adds a schema binding definition to the existing schema binding definitions in the configuration for the specified Group. Schemas with a schema binding definition are automatically imported into queries run against any App Server in the group. : @param $CONFIG
 : @param $GROUP_ID
 : @param $SCHEMAS
 : @return element(configuration)
 :)

try {
	admin:group-add-schema($CONFIG, xs:unsignedLong($GROUP_ID), $SCHEMAS)
} catch($error) {
	$error
}