xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the current MarkLogic product edition. : @return xs:string
 :)

try {
	xdmp:product-edition()
} catch($error) {
	$error
}