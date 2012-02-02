xquery version "1.0-ml" encoding "utf-8";



declare variable $COLLATION_URI as xs:string external;

(:
 : Returns the canonical URI for the given URI, if it represents a valid collation. A canonical URI is the unique string MarkLogic Server uses to identify a given collation. The canonical URI string places any attributes that occur in the URI in a predefined order, and it removes any attributes that are redundant due to locale defaults. : @param $COLLATION_URI
 : @return xs:string
 :)

try {
	xdmp:collation-canonical-uri(xs:string($COLLATION_URI))
} catch($error) {
	$error
}