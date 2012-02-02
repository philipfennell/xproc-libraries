xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;

(:
 : This function constructs an element word query through specification. : @param $NAMESPACE
 : @param $LOCALNAME
 : @return element(db:element-word-query-through)
 :)

try {
	admin:database-element-word-query-through(xs:string($NAMESPACE), xs:string($LOCALNAME))
} catch($error) {
	$error
}