xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function returns the range index optimize setting for the specified database from the configuration. When set to facet-time , range indexes are optimized to minimize the amount of CPU time used. When set to memory-size , range indexes are optimized to minimize the amount of memory used. : @param $CONFIG
 : @param $DATABASE_ID
 : @return xs:string
 :)

try {
	admin:database-get-range-index-optimize($CONFIG, xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}