xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $EVENTS as element(gr:event)* := <events/>;

(:
 : This function adds trace events to the configuration. : @param $CONFIG
 : @param $GROUP_ID
 : @param $EVENTS
 : @return element(configuration)
 :)

try {
	admin:group-add-trace-event($CONFIG, xs:unsignedLong($GROUP_ID), $EVENTS)
} catch($error) {
	$error
}