xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the database ID of the triggers database associated with the current database. : @return xs:unsignedLong
 :)

try {
	xdmp:triggers-database()
} catch($error) {
	$error
}