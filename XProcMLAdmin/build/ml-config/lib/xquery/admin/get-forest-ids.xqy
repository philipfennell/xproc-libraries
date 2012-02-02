xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;

(:
 : This function returns all the forest IDs from the configuration. : @param $CONFIG
 : @return xs:unsignedLong*
 :)

try {
	admin:get-forest-ids($CONFIG)
} catch($error) {
	$error
}