xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_ID as xs:string external;
declare variable $FOREST_NAME as xs:string external;
declare variable $DATA_DIRECTORY as xs:string external;

(:
 : This function creates a new forest specification with the same settings as the forest with the specified ID. The new forest configuration will have the specified name. It copies the forest configuration, but does not copy the forest data. : @param $CONFIG
 : @param $FOREST_ID
 : @param $FOREST_NAME
 : @param $DATA_DIRECTORY
 : @return element(configuration)
 :)

try {
	admin:forest-copy($CONFIG, xs:unsignedLong($FOREST_ID), xs:string($FOREST_NAME), xs:string($DATA_DIRECTORY))
} catch($error) {
	$error
}