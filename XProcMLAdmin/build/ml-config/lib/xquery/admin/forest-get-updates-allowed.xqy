xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;

(:
 : This function returns the state of what kinds of updates are allowed for the specified forest. : @param $CONFIG
 : @param $FOREST_ID
 : @return xs:string
 :)

try {
	admin:forest-get-updates-allowed($CONFIG, xs:unsignedLong($FOREST_ID))
} catch($error) {
	$error
}