xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;
declare variable $WEIGHT as xs:string external;
declare variable $ATTRIBUTE_NAMESPACE as xs:string external;
declare variable $ATTRIBUTE_LOCALNAME as xs:string external;
declare variable $ATTRIBUTE_VALUE as xs:string external;

(:
 : This function constructs an included element specification. : @param $NAMESPACE
 : @param $LOCALNAME
 : @param $WEIGHT
 : @param $ATTRIBUTE_NAMESPACE
 : @param $ATTRIBUTE_LOCALNAME
 : @param $ATTRIBUTE_VALUE
 : @return element(db:included-element)
 :)

try {
	admin:database-included-element(xs:string($NAMESPACE), xs:string($LOCALNAME), xs:double($WEIGHT), xs:string($ATTRIBUTE_NAMESPACE), xs:string($ATTRIBUTE_LOCALNAME), xs:string($ATTRIBUTE_VALUE))
} catch($error) {
	$error
}