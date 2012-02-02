xquery version "1.0-ml" encoding "utf-8";
(:
 : A 'Custom URI Module' for CORB.
 : Returns a count of the number of documents in a database along with a list
 : of their URIs.
 :)
let $uris := cts:uris('', 'document')
return ($uris)
