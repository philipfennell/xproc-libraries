xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;

(:
 : This function saves a configuration specification to the cluster configuration files, without restarting MarkLogic Server. If you use this function to save any changes that require a server restart ("cold" changes such as App Server port assignment changes), then the changes will not take effect until the next time MarkLogic Server restarts (although they will be saved in the configuration). If you want MarkLogic Server to automatically restart when needed, use admin:save-configuration instead. : @param $CONFIG
 : @return xs:unsignedLong*
 :)

try {
	admin:save-configuration-without-restart($CONFIG),
	admin:get-configuration()
} catch($error) {
	$error
}