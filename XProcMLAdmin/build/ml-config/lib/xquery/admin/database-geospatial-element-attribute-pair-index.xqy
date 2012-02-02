xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $PARENT_NAMESPACE as xs:string external;
declare variable $PARENT_LOCALNAME as xs:string external;
declare variable $LATITUDE_NAMESPACE as xs:string external;
declare variable $LATITUDE_LOCALNAME as xs:string external;
declare variable $LONGITUDE_NAMESPACE as xs:string external;
declare variable $LONGITUDE_LOCALNAME as xs:string external;
declare variable $COORDINATE_SYSTEM as xs:string external;
declare variable $RANGE_VALUE_POSITIONS as xs:string external;

(:
 : This function constructs a geospatial element attribute pair index specification. : @param $PARENT_NAMESPACE
 : @param $PARENT_LOCALNAME
 : @param $LATITUDE_NAMESPACE
 : @param $LATITUDE_LOCALNAME
 : @param $LONGITUDE_NAMESPACE
 : @param $LONGITUDE_LOCALNAME
 : @param $COORDINATE_SYSTEM
 : @param $RANGE_VALUE_POSITIONS
 : @return element(db:geospatial-element-attribute-pair-index)
 :)

try {
	admin:database-geospatial-element-attribute-pair-index(xs:string($PARENT_NAMESPACE), xs:string($PARENT_LOCALNAME), xs:string($LATITUDE_NAMESPACE), xs:string($LATITUDE_LOCALNAME), xs:string($LONGITUDE_NAMESPACE), xs:string($LONGITUDE_LOCALNAME), xs:string($COORDINATE_SYSTEM), xs:boolean($RANGE_VALUE_POSITIONS))
} catch($error) {
	$error
}