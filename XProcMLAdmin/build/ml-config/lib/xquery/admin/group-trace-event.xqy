xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $EVENT_ID as xs:string external;

(:
 : This function constructs an event element for the specified event name. : @param $EVENT_ID
 : @return element(gr:event)
 :)

try {
	admin:group-trace-event(xs:string($EVENT_ID))
} catch($error) {
	$error
}