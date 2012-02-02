xquery version "1.0-ml" encoding "utf-8";



declare variable $FUNCTION as xs:string external;
declare variable $PARAMS_1_TO_N as xs:string* external;

(:
 : Applies an xdmp:function with the given parameters. : @param $FUNCTION
 : @param $PARAMS_1_TO_N
 : @return item()*
 :)

try {
	xdmp:apply(xdmp:function($FUNCTION), if (fn:matches($PARAMS_1_TO_N, '\d+')) then xs:unsignedLong($PARAMS_1_TO_N) else xs:string($PARAMS_1_TO_N))
} catch($error) {
	$error
}