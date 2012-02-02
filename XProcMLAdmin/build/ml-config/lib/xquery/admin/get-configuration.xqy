xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;


(:
 : Loads the admin configuration into memory for use by other functions in the Admin module. : @return element(configuration)
 :)

try {
	admin:get-configuration()
} catch($error) {
	$error
}