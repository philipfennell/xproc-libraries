xquery version "1.0-ml" encoding "utf-8";



declare variable $ELEMENT as element() := <element/>;

(:
 : Returns the schema-defined content-type of an element ("empty", "simple", "element-only", or "mixed"). : @param $ELEMENT
 : @return xs:string
 :)

try {
	xdmp:element-content-type($ELEMENT)
} catch($error) {
	$error
}