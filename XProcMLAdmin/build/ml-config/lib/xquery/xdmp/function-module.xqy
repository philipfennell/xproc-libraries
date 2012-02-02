xquery version "1.0-ml" encoding "utf-8";



declare variable $FUNCTION as xs:string external;

(:
 : Returns the module location (if any) that the xdmp:function value refers to. : @param $FUNCTION
 : @return xs:string
 :)

try {
	xdmp:function-module(xdmp:function($FUNCTION))
} catch($error) {
	$error
}