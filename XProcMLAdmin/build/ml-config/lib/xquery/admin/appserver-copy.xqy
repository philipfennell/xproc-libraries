xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $APPSERVER_ID as xs:string external;
declare variable $TARGET_GROUP_ID as xs:string external;
declare variable $APPSERVER_NAME as xs:string external;
declare variable $PORT as xs:string external;

(:
 : This function creates a new App Server specification with the same settings as the App Server with the specified ID. The new App Server configuration will have the specified name. You can copy the App Server to a new one either in the same group (by specifying $old-group-id and $new-group-id with the same group ID) or in a different group. : @param $CONFIG
 : @param $APPSERVER_ID
 : @param $TARGET_GROUP_ID
 : @param $APPSERVER_NAME
 : @param $PORT
 : @return element(configuration)
 :)

try {
	admin:appserver-copy($CONFIG, xs:unsignedLong($APPSERVER_ID), xs:unsignedLong($TARGET_GROUP_ID), xs:string($APPSERVER_NAME), xs:unsignedLong($PORT))
} catch($error) {
	$error
}