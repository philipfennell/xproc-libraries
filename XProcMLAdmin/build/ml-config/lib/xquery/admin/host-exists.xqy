xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $HOST_NAME as xs:string external;

(:
 : This function determines whether or not the specified Host exists. Returns true if the Host exists, otherwise false is returned. : @param $CONFIG
 : @param $HOST_NAME
 : @return xs:boolean
 :)

try {
	admin:host-exists($CONFIG, xs:string($HOST_NAME))
} catch($error) {
	$error
}