xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets the SGML character entity output setting in the configuration for the specified App Server. The SGML setting determines how characters that can be represented as SGML entites are serialized upon output by default in a query against the specified App Server. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-output-sgml-character-entities($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:string($VALUE))
} catch($error) {
	$error
}