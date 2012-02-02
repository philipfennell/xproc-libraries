xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $PARENT_NAMESPACE as xs:string external;
declare variable $PARENT_LOCALNAME as xs:string external;
declare variable $NAMESPACE as xs:string external;
declare variable $LOCALNAME as xs:string external;
declare variable $COLLATION as xs:string external;

(:
 : This function constructs an element attribute word lexicon specification. : @param $PARENT_NAMESPACE
 : @param $PARENT_LOCALNAME
 : @param $NAMESPACE
 : @param $LOCALNAME
 : @param $COLLATION
 : @return element(db:element-attribute-word-lexicon)
 :)

try {
	admin:database-element-attribute-word-lexicon(xs:string($PARENT_NAMESPACE), xs:string($PARENT_LOCALNAME), xs:string($NAMESPACE), xs:string($LOCALNAME), xs:string($COLLATION))
} catch($error) {
	$error
}