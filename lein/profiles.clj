{:xsc {:plugins [[lein-ancient "0.6.14"]
                 [lein-try "0.4.3"]
                 [lein-license "0.1.8"]]
       :signing {:gpg-key "ED4FB884"}
       :aliases {"qi" ["ancient" "upgrade" ":no-tests" ":interactive"]
                 "q"  ["ancient" "upgrade" ":no-tests"]}}
 :injections
 {:dependencies [[im.chit/lucid.core.inject "1.3.13"]
                 [im.chit/lucid.core.debug "1.3.13"]
                 [im.chit/lucid.package "1.3.13"]
                 [fipp "0.6.12"]]
  :injections [(require 'lucid.core.inject)
               (require 'lucid.package)
               (require 'fipp.edn)
               (lucid.core.inject/in
                 [lucid.package :refer [pull]]

                 clojure.core
                 [lucid.core.debug]
                 [fipp.edn :refer [[pprint p>]]])]}
 :dox {:plugins [[me.raynes/dox "0.1.0"]]}
 :user [:xsc :injections]}
