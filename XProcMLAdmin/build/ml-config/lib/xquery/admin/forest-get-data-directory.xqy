xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;

(:
 : This function returns the name of the data directory of the specified forest. : @param $CONFIG
 : @param $FOREST_ID
 : @return xs:string
 :)

try {
	admin:forest-get-data-directory($CONFIG, xs:unsignedLong($FOREST_ID))
} catch($error) {
	$error
}