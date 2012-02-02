xquery version "1.0-ml" encoding "utf-8";



declare variable $DOCUMENT as xs:string external;

(:
 : Analyzes binary, text, or XML data and suggests possible pairs of encoding and language, with a confidence score for each pair. Scores of 10 and above are high confidence recommendations. The results are given in order of decreasing score. Accuracy may be poor for short documents. : @param $DOCUMENT
 : @return element()*
 :)

try {
	xdmp:encoding-language-detect(node()($DOCUMENT))
} catch($error) {
	$error
}