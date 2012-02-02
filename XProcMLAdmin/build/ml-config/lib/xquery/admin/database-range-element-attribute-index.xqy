xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $SCALAR_TYPE as xs:string external;
declare variable $PARENT_NAMESPACE as xs:string external;
declare variable $PARENT_LOCALNAME as xs:string external;
declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;
declare variable $COLLATION as xs:string external;
declare variable $RANGE_VALUE_POSITIONS as xs:string external;

(:
 : This function constructs a range element attribute index specification. : @param $SCALAR_TYPE
 : @param $PARENT_NAMESPACE
 : @param $PARENT_LOCALNAME
 : @param $NAMESPACE
 : @param $LOCALNAME
 : @param $COLLATION
 : @param $RANGE_VALUE_POSITIONS
 : @return element(db:range-element-attribute-index)
 :)

try {
	admin:database-range-element-attribute-index(xs:string($SCALAR_TYPE), xs:string($PARENT_NAMESPACE), xs:string($PARENT_LOCALNAME), xs:string($NAMESPACE), xs:string($LOCALNAME), xs:string($COLLATION), xs:boolean($RANGE_VALUE_POSITIONS))
} catch($error) {
	$error
}