xquery version "1.0-ml" encoding "utf-8";



declare variable $FUNCTION as xs:string external;
declare variable $MODULE_PATH as xs:string* external;

(:
 : Returns a function value as an xdmp:function type. You can return an xdmp:function from an expression or a function. You can execute the function referred to by an xdmp:function by passing the xdmp:function value to xdmp:apply . : @param $FUNCTION
 : @param $MODULE_PATH
 : @return xdmp:function
 :)

try {
	xdmp:function(xs:QName($FUNCTION), xs:string($MODULE_PATH))
} catch($error) {
	$error
}