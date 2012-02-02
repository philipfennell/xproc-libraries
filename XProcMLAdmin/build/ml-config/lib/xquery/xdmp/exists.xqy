xquery version "1.0-ml" encoding "utf-8";



declare variable $EXPRESSION as xs:string external;

(:
 : Returns true if any fragment is selected by an expression, false if no fragments are selected. This can be used as a fast existence check. : @param $EXPRESSION
 : @return xs:integer
 :)

try {
	xdmp:exists(if (fn:matches($EXPRESSION, '\d+')) then xs:unsignedLong($EXPRESSION) else xs:string($EXPRESSION))
} catch($error) {
	$error
}