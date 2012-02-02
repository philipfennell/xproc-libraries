xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the unique key of the current request. : @return xs:unsignedLong
 :)

try {
	xdmp:request()
} catch($error) {
	$error
}