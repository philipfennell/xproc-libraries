xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_NAME as xs:string external;

(:
 : This function returns the ID for the specified database from the configuration. The difference between this function and xdmp:database() is that the ID from this function can come from a database that has not yet been saved (that is, from a database that has been created in the same query with the Admin library but has not yet been saved to the cluster configuration files). This ID enables you to completely configure a newly created database without the need to first save the configuration. : @param $CONFIG
 : @param $DATABASE_NAME
 : @return xs:unsignedLong
 :)

try {
	admin:database-get-id($CONFIG, xs:string($DATABASE_NAME))
} catch($error) {
	$error
}