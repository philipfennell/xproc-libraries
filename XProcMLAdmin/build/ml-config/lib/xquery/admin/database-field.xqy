xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $FIELD_NAME as xs:string external;
declare variable $INCLUDE_ROOT as xs:string external;

(:
 : This function constructs a field specification. : @param $FIELD_NAME
 : @param $INCLUDE_ROOT
 : @return element(db:field)
 :)

try {
	admin:database-field(xs:string($FIELD_NAME), xs:boolean($INCLUDE_ROOT))
} catch($error) {
	$error
}