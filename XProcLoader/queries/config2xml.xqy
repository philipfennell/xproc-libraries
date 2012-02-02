xquery version "1.0" encoding "utf-8";

declare namespace c = "http://www.w3.org/ns/xproc-step";

<config xmlns="http://xmlcalabash.com/ns/extensions/marklogic">
{for $line in fn:tokenize(/c:data/text(), '\n')
	let $fieldName := translate(fn:lower-case(fn:substring-before($line, '=')), '_', '-')
	order by $fieldName
	return
		element {$fieldName} {fn:substring-after($line, '=')}
}
</config>