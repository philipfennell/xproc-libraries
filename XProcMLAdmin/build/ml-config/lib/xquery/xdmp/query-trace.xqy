xquery version "1.0-ml" encoding "utf-8";



declare variable $ENABLED as xs:string external;

(:
 : Enables or disables tracing of this query. When query tracing is enabled, "info" level messages are logged detailing the search optimizations performed. : @param $ENABLED
 : @return empty-sequence()
 :)

try {
	xdmp:query-trace(xs:boolean($ENABLED))
} catch($error) {
	$error
}