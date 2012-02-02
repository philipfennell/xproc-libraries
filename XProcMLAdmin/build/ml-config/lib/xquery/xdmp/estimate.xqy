xquery version "1.0-ml" encoding "utf-8";



declare variable $EXPRESSION as xs:string external;
declare variable $MAXIMUM as xs:string* external;

(:
 : Returns the number of fragments selected by an expression. This can be used as a fast estimate of the number of items in a sequence. : @param $EXPRESSION
 : @param $MAXIMUM
 : @return xs:integer
 :)

try {
	xdmp:estimate(if (fn:matches($EXPRESSION, '\d+')) then xs:unsignedLong($EXPRESSION) else xs:string($EXPRESSION), xs:double($MAXIMUM))
} catch($error) {
	$error
}