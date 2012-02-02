xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;
declare variable $ID as xs:string external;
declare variable $VARS as xs:string* external;
declare variable $MODULES as xs:string* external;
declare variable $ROOT as xs:string* external;

(:
 : [DEPRECATED: use xdmp:invoke with the database option instead] Returns the result of evaluating a module at the given path. : @param $URI
 : @param $ID
 : @param $VARS
 : @param $MODULES
 : @param $ROOT
 : @return item()*
 :)

try {
	xdmp:invoke-in(xs:string($URI), xs:unsignedLong($ID), if (fn:matches($VARS, '\d+')) then xs:unsignedLong($VARS) else xs:string($VARS), xs:unsignedLong($MODULES), xs:string($ROOT))
} catch($error) {
	$error
}