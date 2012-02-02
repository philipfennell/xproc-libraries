xquery version "1.0-ml" encoding "utf-8";




(:
 : Returns the XQuery language version of the calling module. Currently supported XQuery versions are: "0.9-ml": The legacy MarkLogic XQuery version. This was the only XQuery version available on MarkLogic Server 3.2 and earlier. It is based on the May 2003 XQuery Draft Recommendation, with MarkLogic extensions "1.0-ml": XQuery version 1.0, with MarkLogic extensions. This is the preferred version of XQuery beginning with release 4.0. "1.0": Strict XQuery version 1.0. This XQuery version complies as closely as possible with the published XQuery 1.0 specification. : @return xs:string
 :)

try {
	xdmp:xquery-version()
} catch($error) {
	$error
}