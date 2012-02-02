xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $APPSERVER_NAME as xs:string external;
declare variable $ROOT as xs:string external;
declare variable $PORT as xs:string external;
declare variable $DATABASE_ID as xs:string external;

(:
 : This function creates a new WebDAV App Server with the specified name, library, and port in the configuration. : @param $CONFIG
 : @param $GROUP_ID
 : @param $APPSERVER_NAME
 : @param $ROOT
 : @param $PORT
 : @param $DATABASE_ID
 : @return element(configuration)
 :)

try {
	admin:webdav-server-create($CONFIG, xs:unsignedLong($GROUP_ID), xs:string($APPSERVER_NAME), xs:string($ROOT), xs:unsignedLong($PORT), xs:unsignedLong($DATABASE_ID))
} catch($error) {
	$error
}