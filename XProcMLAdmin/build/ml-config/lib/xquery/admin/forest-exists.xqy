xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_NAME as xs:string external;

(:
 : This function determines whether or not the specified forest exists. Returns true if the forest exists, otherwise false is returned. : @param $CONFIG
 : @param $FOREST_NAME
 : @return xs:boolean
 :)

try {
	admin:forest-exists($CONFIG, xs:string($FOREST_NAME))
} catch($error) {
	$error
}