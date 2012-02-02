xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $PREFIX as xs:string external;
declare variable $NAMESPACE_URI as xs:string external;

(:
 : This function constructs a namespace element with the specified prefix and URI. : @param $PREFIX
 : @param $NAMESPACE_URI
 : @return element(gr:namespace)
 :)

try {
	admin:group-namespace(xs:string($PREFIX), xs:string($NAMESPACE_URI))
} catch($error) {
	$error
}