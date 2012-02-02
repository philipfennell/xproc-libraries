xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $HOSTS as xs:string external;

(:
 : This function restarts MarkLogic Server for the specified hosts. : @param $HOSTS
 : @return empty-sequence()
 :)

try {
	admin:restart-hosts(xs:unsignedLong($HOSTS))
} catch($error) {
	$error
}