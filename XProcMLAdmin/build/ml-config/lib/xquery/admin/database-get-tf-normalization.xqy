xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function returns the current term-frequency normalization setting for the database. The returned value is either ( scaled-log ), which means to scale the term frequency based on the size of the document, or unscaled-log , which means to use term frequency as a function of the actual term frequency in a document, regardless of the document size. : @param $CONFIG
 : @param $DATABASE_ID
 : @return xs:string
 :)

try {
	admin:database-get-tf-normalization($CONFIG, xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}