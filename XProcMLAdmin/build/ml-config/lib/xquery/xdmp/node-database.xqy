xquery version "1.0-ml" encoding "utf-8";



declare variable $NODE as xs:string external;

(:
 : Returns the database id where the parameter is stored. If the specified node does not come from a document in a database, then xdmp:node-database returns an empty list. : @param $NODE
 : @return xs:unsignedLong?
 :)

try {
	xdmp:node-database(node()($NODE))
} catch($error) {
	$error
}