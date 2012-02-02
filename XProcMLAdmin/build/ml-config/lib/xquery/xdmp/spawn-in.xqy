xquery version "1.0-ml" encoding "utf-8";



declare variable $PATH as xs:string external;
declare variable $ID as xs:string external;
declare variable $VARS as xs:string* external;
declare variable $MODULES as xs:string* external;
declare variable $ROOT as xs:string* external;

(:
 : [DEPRECATED: use xdmp:spawn with the database option instead] Place the specified module on the task queue for evaluation. It will be evaluated in the given database. : @param $PATH
 : @param $ID
 : @param $VARS
 : @param $MODULES
 : @param $ROOT
 : @return empty-sequence()
 :)

try {
	xdmp:spawn-in(xs:string($PATH), xs:unsignedLong($ID), if (fn:matches($VARS, '\d+')) then xs:unsignedLong($VARS) else xs:string($VARS), xs:unsignedLong($MODULES), xs:string($ROOT))
} catch($error) {
	$error
}