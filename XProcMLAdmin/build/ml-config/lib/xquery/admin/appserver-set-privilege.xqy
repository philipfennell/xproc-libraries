xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $VALUE as xs:string external;

(:
 : This function sets an execute privilege in the configuration for the specified App Server. When a privilege is set, the user who makes a request to the App Server must have been granted (via a role, either directly or indirectly) the specified privilege. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $VALUE
 : @return element(configuration)
 :)

try {
	admin:appserver-set-privilege($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:unsignedLong($VALUE))
} catch($error) {
	$error
}