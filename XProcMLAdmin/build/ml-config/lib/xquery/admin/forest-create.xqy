xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $FOREST_NAME as xs:string external;
declare variable $HOST_ID as xs:string external;
declare variable $DATA_DIRECTORY as xs:string external;

(:
 : This function creates a new forest configuration. : @param $CONFIG
 : @param $FOREST_NAME
 : @param $HOST_ID
 : @param $DATA_DIRECTORY
 : @return element(configuration)
 :)

try {
	admin:forest-create($CONFIG, xs:string($FOREST_NAME), xs:unsignedLong($HOST_ID), xs:string($DATA_DIRECTORY))
} catch($error) {
	$error
}