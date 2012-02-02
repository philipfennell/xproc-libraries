xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAME as xs:string external;
declare variable $EXTENSIONS as xs:string external;
declare variable $FORMAT as xs:string external;

(:
 : This function constructs a mimetype specification. : @param $NAME
 : @param $EXTENSIONS
 : @param $FORMAT
 : @return element(mt:mimetype)
 :)

try {
	admin:mimetype(xs:string($NAME), xs:string($EXTENSIONS), xs:string($FORMAT))
} catch($error) {
	$error
}