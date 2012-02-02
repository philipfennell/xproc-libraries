xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_NAME as xs:string external;

(:
 : This function determines whether or not the specified database exists. Returns true if the database exists, otherwise false is returned. : @param $CONFIG
 : @param $DATABASE_NAME
 : @return xs:boolean
 :)

try {
	admin:database-exists($CONFIG, xs:string($DATABASE_NAME))
} catch($error) {
	$error
}