xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $SCALAR_TYPE as xs:string external;
declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;
declare variable $COLLATION as xs:string external;
declare variable $RANGE_VALUE_POSITIONS as xs:string external;

(:
 : This function constructs a range element index specification. : @param $SCALAR_TYPE
 : @param $NAMESPACE
 : @param $LOCALNAME
 : @param $COLLATION
 : @param $RANGE_VALUE_POSITIONS
 : @return element(db:range-element-index)
 :)

try {
	admin:database-range-element-index(xs:string($SCALAR_TYPE), xs:string($NAMESPACE), xs:string($LOCALNAME), xs:string($COLLATION), xs:boolean($RANGE_VALUE_POSITIONS))
} catch($error) {
	$error
}