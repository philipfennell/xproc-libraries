xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;
declare variable $COLLATION as xs:string external;

(:
 : This function constructs an element word lexicon specification. : @param $NAMESPACE
 : @param $LOCALNAME
 : @param $COLLATION
 : @return element(db:element-word-lexicon)
 :)

try {
	admin:database-element-word-lexicon(xs:string($NAMESPACE), xs:string($LOCALNAME), xs:string($COLLATION))
} catch($error) {
	$error
}