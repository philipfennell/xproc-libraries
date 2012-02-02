xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns a sequence of the IDs of all the databases in the system. : @return xs:unsignedLong*
 :)

try {
	xdmp:databases()
} catch($error) {
	$error
}