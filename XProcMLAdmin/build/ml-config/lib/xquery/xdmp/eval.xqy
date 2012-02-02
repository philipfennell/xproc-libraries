xquery version "1.0-ml" encoding "utf-8";



declare variable $XQUERY as xs:string external;
declare variable $VARS as xs:string* external;
declare variable $OPTIONS as xs:string* external;

(:
 : Returns the result of evaluating a string as an XQuery module. : @param $XQUERY
 : @param $VARS
 : @param $OPTIONS
 : @return item()*
 :)

try {
	xdmp:eval(xs:string($XQUERY), if (fn:matches($VARS, '\d+')) then xs:unsignedLong($VARS) else xs:string($VARS), node()($OPTIONS))
} catch($error) {
	$error
}