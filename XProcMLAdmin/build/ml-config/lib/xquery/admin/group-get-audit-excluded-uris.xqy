xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;

(:
 : This function returns the uris excluded from auditing. If auditing has a "inclusion" restriction, this function returns the empty sequence. : @param $CONFIG
 : @param $GROUP_ID
 : @return xs:string*
 :)

try {
	admin:group-get-audit-excluded-uris($CONFIG, xs:unsignedLong($GROUP_ID))
} catch($error) {
	$error
}