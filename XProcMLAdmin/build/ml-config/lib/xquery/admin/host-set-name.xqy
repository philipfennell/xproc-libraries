xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $HOST_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function changes the name of an existing host to the newly specified value. : @param $CONFIG
 : @param $HOST_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:host-set-name($CONFIG, xs:unsignedLong($HOST_ID), xs:string($VALUE))
} catch($error) {
	$error
}