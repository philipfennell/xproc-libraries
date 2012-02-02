xquery version "1.0-ml" encoding "utf-8";




(:
 : Retrieves the current server log level. : @return xs:string
 :)

try {
	xdmp:log-level()
} catch($error) {
	$error
}