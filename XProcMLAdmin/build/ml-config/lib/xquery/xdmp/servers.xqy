xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns a sequence of the IDs of all the App Servers in the system. : @return xs:unsignedLong*
 :)

try {
	xdmp:servers()
} catch($error) {
	$error
}