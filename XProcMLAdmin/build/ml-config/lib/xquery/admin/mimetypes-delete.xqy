xquery version "1.0-ml" encoding "utf-8";

import module namespace admin = "http://marklogic.com/xdmp/admin" at "/MarkLogic/admin.xqy" ;

declare variable $CONFIG as element(configuration) := <config/>;
declare variable $MIMETYPES as element(mt:mimetype)* := <mimetypes/>;

(:
 : This function deletes mimetypes from the configuration. This function always requires a server restart to take effect. : @param $CONFIG
 : @param $MIMETYPES
 : @return element(configuration)
 :)

try {
	admin:mimetypes-delete($CONFIG, $MIMETYPES)
} catch($error) {
	$error
}