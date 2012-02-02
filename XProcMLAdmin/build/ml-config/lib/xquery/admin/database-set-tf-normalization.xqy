xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function specifies whether to use the default term-frequency normalization ( scaled-log ), which scales the term frequency based on the size of the document, or to use the unscaled-log , which uses term frequency as a function of the actual term frequency in a document, regardless of the document size. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:database-set-tf-normalization($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($VALUE))
} catch($error) {
	$error
}