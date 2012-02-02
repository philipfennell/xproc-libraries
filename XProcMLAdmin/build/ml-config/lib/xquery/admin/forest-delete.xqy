xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_IDS as xs:string external;
declare variable $DELETE_DATA as xs:string external;

(:
 : This function deletes the configuration for the specified forest from the configuration. : @param $CONFIG
 : @param $FOREST_IDS
 : @param $DELETE_DATA
 : @return element(configuration)
 :)

try {
	admin:forest-delete($CONFIG, xs:unsignedLong($FOREST_IDS), xs:boolean($DELETE_DATA))
} catch($error) {
	$error
}