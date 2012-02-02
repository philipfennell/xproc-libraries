xquery version "1.0-ml" encoding "utf-8";



declare variable $NODE as xs:string external;

(:
 : Returns the document-uri property of the parameter or its ancestor. : @param $NODE
 : @return xs:string?
 :)

try {
	xdmp:node-uri(node()($NODE))
} catch($error) {
	$error
}