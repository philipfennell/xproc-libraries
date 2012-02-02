xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets one or more client certificate authorities that sign client certificates for the specified App Server. This function is typically used along with the pki:insert-trusted-certificates and pki:get-trusted-certificate-ids functions to import trusted Certificate Authorities for client certificates. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-ssl-client-certificate-authorities($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:unsignedLong($VALUE))
} catch($error) {
	$error
}