xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $FIELDS as element(db:field)* := <fields/>;

(:
 : This function adds the field specification to the specified database in the configuration. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $FIELDS
 : @return element(configuration)
 :)

try {
	admin:database-add-field($CONFIG, xs:unsignedLong($DATABASE_ID), $FIELDS)
} catch($error) {
	$error
}