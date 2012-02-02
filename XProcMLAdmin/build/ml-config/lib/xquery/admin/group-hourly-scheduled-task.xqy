xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $TASK_PATH as xs:string external;
declare variable $TASK_ROOT as xs:string external;
declare variable $TASK_PERIOD as xs:string external;
declare variable $TASK_MINUTE as xs:string external;
declare variable $TASK_DATABASE as xs:string external;
declare variable $TASK_MODULES as xs:string external;
declare variable $TASK_USER as xs:string external;
declare variable $TASK_HOST as xs:string external;

(:
 : This function constructs a task to be invoked at hourly intervals. : @param $TASK_PATH
 : @param $TASK_ROOT
 : @param $TASK_PERIOD
 : @param $TASK_MINUTE
 : @param $TASK_DATABASE
 : @param $TASK_MODULES
 : @param $TASK_USER
 : @param $TASK_HOST
 : @return element(gr:scheduled-task)
 :)

try {
	admin:group-hourly-scheduled-task(xs:string($TASK_PATH), xs:string($TASK_ROOT), xs:positiveInteger($TASK_PERIOD), xs:nonNegativeInteger($TASK_MINUTE), xs:unsignedLong($TASK_DATABASE), xs:unsignedLong($TASK_MODULES), xs:unsignedLong($TASK_USER), xs:unsignedLong($TASK_HOST))
} catch($error) {
	$error
}