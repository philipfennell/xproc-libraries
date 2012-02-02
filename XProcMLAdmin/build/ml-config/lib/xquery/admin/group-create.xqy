xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_NAME as xs:string external;

(:
 : This function creates a new group with the specified name in the configuration. The new group has the default values. : @param $CONFIG
 : @param $GROUP_NAME
 : @return element(configuration)
 :)

try {
	admin:group-create($CONFIG, xs:string($GROUP_NAME))
} catch($error) {
	$error
}