xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the elapsed time since the start of processing of this query. Gives the same information as the elapsed-time element of the xdmp:query-meters output, but has less overhead than calling xdmp:query-meters . : @return xs:dayTimeDuration
 :)

try {
	xdmp:elapsed-time()
} catch($error) {
	$error
}