xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;
declare variable $COORDINATE_SYSTEM as xs:string external;
declare variable $RANGE_VALUE_POSITIONS as xs:string external;
declare variable $POINT_FORMAT as xs:string* external;

(:
 : This function constructs a geospatial element index specification. : @param $NAMESPACE
 : @param $LOCALNAME
 : @param $COORDINATE_SYSTEM
 : @param $RANGE_VALUE_POSITIONS
 : @param $POINT_FORMAT
 : @return element(db:geospatial-element-index)
 :)

try {
	admin:database-geospatial-element-index(xs:string($NAMESPACE), xs:string($LOCALNAME), xs:string($COORDINATE_SYSTEM), xs:boolean($RANGE_VALUE_POSITIONS), xs:string($POINT_FORMAT))
} catch($error) {
	$error
}