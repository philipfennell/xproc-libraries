xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns true if the TLS protocol is enabled for the group. Otherwise, false is returned. : @param $CONFIG
 : @param $GROUP_ID
 : @return xs:boolean
 :)

try {
	admin:group-get-xdqp-ssl-allow-tls($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}