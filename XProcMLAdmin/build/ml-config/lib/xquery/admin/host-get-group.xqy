xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $HOST_ID as xs:string external;

(:
 : This function returns the group ID for the host with the specified ID. : @param $CONFIG
 : @param $HOST_ID
 : @return xs:unsignedLong
 :)

try {
	admin:host-get-group($CONFIG, xs:unsignedLong($HOST_ID))
} catch($error) {
	$error
}