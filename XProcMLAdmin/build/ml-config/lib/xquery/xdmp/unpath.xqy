xquery version "1.0-ml" encoding "utf-8";



declare variable $EXPR as xs:string external;

(:
 : Evaluate a string as an XPath and return the corresponding node(s). Any value that is the result of xdmp:path is a valid input to xdmp:unpath . Any invalid inputs throw an XDMP-UNPATH exception. To evaluate non-XPath expressions, use xdmp:value . : @param $EXPR
 : @return item()*
 :)

try {
	xdmp:unpath(xs:string($EXPR))
} catch($error) {
	$error
}