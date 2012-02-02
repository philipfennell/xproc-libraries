xquery version "1.0-ml" encoding "utf-8";



declare variable $VARIABLE as xs:string external;
declare variable $EXPR as xs:string external;

(:
 : Set the value of a variable to the specified expression. The xdmp:set command allows you to introduce changes to the state (side effects) of a query by changing the value of a variable to something other than what it is bound to. : @param $VARIABLE
 : @param $EXPR
 : @return empty-sequence()
 :)

try {
	xdmp:set(if (fn:matches($VARIABLE, '\d+')) then xs:unsignedLong($VARIABLE) else xs:string($VARIABLE), if (fn:matches($EXPR, '\d+')) then xs:unsignedLong($EXPR) else xs:string($EXPR))
} catch($error) {
	$error
}