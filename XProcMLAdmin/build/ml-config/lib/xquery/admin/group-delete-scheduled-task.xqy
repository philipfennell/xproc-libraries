xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $GROUP_ID as xs:string external;
declare variable $SCHEDULED_TASKS as element(gr:scheduled-task)* := <scheduled-tasks/>;

(:
 : This function deletes one or more scheduled tasks from the specified group. : @param $CONFIG
 : @param $GROUP_ID
 : @param $SCHEDULED_TASKS
 : @return element(configuration)
 :)

try {
	admin:group-delete-scheduled-task($CONFIG, xs:unsignedLong($GROUP_ID), $SCHEDULED_TASKS)
} catch($error) {
	$error
}