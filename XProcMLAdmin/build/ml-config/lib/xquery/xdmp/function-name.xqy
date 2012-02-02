xquery version "1.0-ml" encoding "utf-8";



declare variable $FUNCTION as xs:string external;

(:
 : Returns the QName of the function(s) that the xdmp:function refers to. : @param $FUNCTION
 : @return xs:QName
 :)

try {
	xdmp:function-name(xdmp:function($FUNCTION))
} catch($error) {
	$error
}