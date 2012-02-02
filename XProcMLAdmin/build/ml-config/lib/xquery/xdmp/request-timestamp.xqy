xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the system timestamp for this request if the request is a query statement. Returns the empty sequence if the current request is an update statement. : @return xs:unsignedLong?
 :)

try {
	xdmp:request-timestamp()
} catch($error) {
	$error
}