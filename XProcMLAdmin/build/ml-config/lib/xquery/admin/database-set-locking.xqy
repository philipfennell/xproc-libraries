xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the locking setting for the specified database in the configuration. When set to strict , locking enforces mutual exclusion on existing documents and on new documents. When set to fast , locking enforces mutual exclusion on existing documents but not on new documents. When set to off , locking does not enforce mutual exclusion on existing documents or on new documents. : @param $CONFIG
 : @param $DATABASE_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:database-set-locking($CONFIG, xs:unsignedLong($DATABASE_ID), xs:string($VALUE))
} catch($error) {
	$error
}