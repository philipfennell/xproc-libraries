xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;

(:
 : This function constructs an excluded element specification. : @param $NAMESPACE
 : @param $LOCALNAME
 : @return element(db:excluded-element)
 :)

try {
	admin:database-excluded-element(xs:string($NAMESPACE), xs:string($LOCALNAME))
} catch($error) {
	$error
}