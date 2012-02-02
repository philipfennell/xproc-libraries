xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $MASTER_ID as xs:string external;
declare variable $REPLICA_ID as xs:string external;

(:
 : This function removes a forest replica from a master forest. : @param $CONFIG
 : @param $MASTER_ID
 : @param $REPLICA_ID
 : @return element(configuration)
 :)

try {
	admin:forest-remove-replica($CONFIG, xs:unsignedLong($MASTER_ID), xs:unsignedLong($REPLICA_ID))
} catch($error) {
	$error
}