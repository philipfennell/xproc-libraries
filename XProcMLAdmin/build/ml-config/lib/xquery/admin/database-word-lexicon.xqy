xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $COLLATION as xs:string external;

(:
 : This function constructs a word lexicon specification. : @param $COLLATION
 : @return element(db:word-lexicon)
 :)

try {
	admin:database-word-lexicon(xs:string($COLLATION))
} catch($error) {
	$error
}