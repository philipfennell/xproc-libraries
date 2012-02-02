xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_NAME as xs:string external;

(:
 : This function determines whether or not the specified Group exists. Returns true if the Group exists, otherwise false is returned. : @param $CONFIG
 : @param $GROUP_NAME
 : @return xs:boolean
 :)

try {
	admin:group-exists($CONFIG, xs:string($GROUP_NAME))
} catch($error) {
	$error
}