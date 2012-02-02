xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the current value of the resource meters for this query sequence. : @return element()
 :)

try {
	xdmp:query-meters()
} catch($error) {
	$error
}