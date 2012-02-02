xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets SSL ciphers for the specified App Server. This is the standard cipher specification string for OpenSSL. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-ssl-ciphers($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:string($VALUE))
} catch($error) {
	$error
}