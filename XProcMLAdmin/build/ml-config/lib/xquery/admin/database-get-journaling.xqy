xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function returns the journaling setting for the specified database in the configuration. When set to strict , the journal protects against MarkLogic Server process failures, host operating system kernel failures, and host hardware failures. When set to fast , the journal protects against MarkLogic Server process failures but not against host operating system kernel failures or host hardware failures. When set to off , the journal does not protect against MarkLogic Server process failures, host operating system kernel failures, or host hardware failures. : @param $CONFIG
 : @param $DATABASE_ID
 : @return xs:string
 :)

try {
	admin:database-get-journaling($CONFIG, xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}