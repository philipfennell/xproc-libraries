xquery version "1.0-ml" encoding "utf-8";



declare variable $XQUERY as xs:string external;

(:
 : Returns a well-formatted XQuery module. : @param $XQUERY
 : @return xs:string
 :)

try {
	xdmp:pretty-print(xs:string($XQUERY))
} catch($error) {
	$error
}