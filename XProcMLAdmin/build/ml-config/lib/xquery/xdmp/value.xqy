xquery version "1.0-ml" encoding "utf-8";



declare variable $EXPR as xs:string external;

(:
 : Evaluate an expression in the context of the current evaluating statement. This differs from xdmp:eval in that xdmp:value preserves all of the context from the calling query, so you do not need to re-define namespaces, variables, and so on. Although the expression retains the context from the calling query, it is evaluated in its own transaction with same-statement isolation. : @param $EXPR
 : @return item()*
 :)

try {
	xdmp:value(xs:string($EXPR))
} catch($error) {
	$error
}