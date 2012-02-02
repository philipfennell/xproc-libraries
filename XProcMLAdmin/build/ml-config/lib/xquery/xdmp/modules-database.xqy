xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the database ID of the modules database. Returns 0 if the current App Server uses the file system for its modules. : @return xs:unsignedLong
 :)

try {
	xdmp:modules-database()
} catch($error) {
	$error
}