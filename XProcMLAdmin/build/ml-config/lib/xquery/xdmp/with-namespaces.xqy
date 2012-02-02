xquery version "1.0-ml" encoding "utf-8";



declare variable $NSBINDINGS as xs:string external;
declare variable $EXPR as xs:string external;

(:
 : Evaluates the expression in the context of a specific set of namespace bindings. : @param $NSBINDINGS
 : @param $EXPR
 : @return item()*
 :)

try {
	xdmp:with-namespaces(xs:string($NSBINDINGS), if (fn:matches($EXPR, '\d+')) then xs:unsignedLong($EXPR) else xs:string($EXPR))
} catch($error) {
	$error
}