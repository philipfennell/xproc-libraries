xquery version "1.0-ml" encoding "utf-8";



declare variable $URI as xs:string external;

(:
 : Returns the content type of the given URI as matched in the mimetypes configuration. xdmp:content-type continues to work too. : @param $URI
 : @return xs:string
 :)

try {
	xdmp:uri-content-type(xs:string($URI))
} catch($error) {
	$error
}