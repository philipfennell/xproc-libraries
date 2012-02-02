xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;

(:
 : This function constructs a fragment root specification. : @param $NAMESPACE
 : @param $LOCALNAME
 : @return element(db:fragment-root)
 :)

try {
	admin:database-fragment-root(xs:string($NAMESPACE), xs:string($LOCALNAME))
} catch($error) {
	$error
}