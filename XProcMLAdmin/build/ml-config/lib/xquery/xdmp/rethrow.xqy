xquery version "1.0-ml" encoding "utf-8";




(:
 : Within the catch section of a try-catch expression, re-throw the currently caught error. : @return empty-sequence()
 :)

try {
	xdmp:rethrow()
} catch($error) {
	$error
}