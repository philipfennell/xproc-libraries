xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;

(:
 : This function saves a configuration specification to the cluster configuration files. It restarts MarkLogic Server for "cold" administrative tasks only (for example, for App Server port assignment changes). If you do not want those "cold" administrative tasks to automatically restart MarkLogic Server, use admin:save-configuration-without-restart instead. : @param $CONFIG
 : @return empty-sequence()
 :)

try {
	admin:save-configuration($CONFIG),
	admin:get-configuration()
} catch($error) {
	$error
}