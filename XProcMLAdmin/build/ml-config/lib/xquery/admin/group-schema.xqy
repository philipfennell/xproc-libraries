xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAMESPACE_URI as xs:string external;
declare variable $SCHEMA_LOCATION as xs:string external;

(:
 : This function constructs a schema element with the specified prefix and URI. : @param $NAMESPACE_URI
 : @param $SCHEMA_LOCATION
 : @return element(gr:schema)
 :)

try {
	admin:group-schema(xs:string($NAMESPACE_URI), xs:string($SCHEMA_LOCATION))
} catch($error) {
	$error
}