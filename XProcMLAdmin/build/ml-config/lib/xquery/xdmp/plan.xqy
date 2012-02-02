xquery version "1.0-ml" encoding "utf-8";



declare variable $EXPRESSION as xs:string external;
declare variable $MAXIMUM as xs:string* external;

(:
 : Returns an XML element recording information about how the given expression will be processed by the index. The information is a structured representation of the information provided in the error log when query trace is enabled. The query will be processed up to the point of getting an estimate of the number of fragments returned by the index. : @param $EXPRESSION
 : @param $MAXIMUM
 : @return element()
 :)

try {
	xdmp:plan(if (fn:matches($EXPRESSION, '\d+')) then xs:unsignedLong($EXPRESSION) else xs:string($EXPRESSION), xs:double($MAXIMUM))
} catch($error) {
	$error
}