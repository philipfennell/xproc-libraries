xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $TASK_PATH as xs:string external;
declare variable $TASK_ROOT as xs:string external;
declare variable $TASK_START as xs:string external;
declare variable $TASK_DATABASE as xs:string external;
declare variable $TASK_MODULES as xs:string external;
declare variable $TASK_USER as xs:string external;
declare variable $TASK_HOST as xs:string external;

(:
 : This function constructs a task to be invoked once, at a specific calendar day and time. : @param $TASK_PATH
 : @param $TASK_ROOT
 : @param $TASK_START
 : @param $TASK_DATABASE
 : @param $TASK_MODULES
 : @param $TASK_USER
 : @param $TASK_HOST
 : @return element(gr:scheduled-task)
 :)

try {
	admin:group-one-time-scheduled-task(xs:string($TASK_PATH), xs:string($TASK_ROOT), xs:dateTime($TASK_START), xs:unsignedLong($TASK_DATABASE), xs:unsignedLong($TASK_MODULES), xs:unsignedLong($TASK_USER), xs:unsignedLong($TASK_HOST))
} catch($error) {
	$error
}