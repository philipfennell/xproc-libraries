xquery version "1.0-ml" encoding "utf-8";



declare variable $XQUERY as xs:string external;
declare variable $ID as xs:string external;
declare variable $VARS as xs:string* external;
declare variable $MODULES as xs:string* external;
declare variable $ROOT as xs:string* external;

(:
 : [DEPRECATED: use xdmp:eval with the database option instead] Returns the result of evaluating a string as an XQuery module in a given database. : @param $XQUERY
 : @param $ID
 : @param $VARS
 : @param $MODULES
 : @param $ROOT
 : @return item()*
 :)

try {
	xdmp:eval-in(xs:string($XQUERY), xs:unsignedLong($ID), if (fn:matches($VARS, '\d+')) then xs:unsignedLong($VARS) else xs:string($VARS), xs:unsignedLong($MODULES), xs:string($ROOT))
} catch($error) {
	$error
}