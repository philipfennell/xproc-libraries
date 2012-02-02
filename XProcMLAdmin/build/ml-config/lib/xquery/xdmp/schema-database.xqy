xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the database ID of the schema database associated with the current database. : @return xs:unsignedLong
 :)

try {
	xdmp:schema-database()
} catch($error) {
	$error
}