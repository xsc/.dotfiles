{:xsc {:plugins [#_[lein-cljfmt "0.4.1"]
                 [lein-ancient "0.6.14"]
                 [lein-try "0.4.3"]
                 [lein-license "0.1.7-SNAPSHOT"]]
       :signing {:gpg-key "ED4FB884"}
       :aliases {"qi"    ["ancient" "upgrade" ":no-tests" ":interactive"]
                 "q"     ["ancient" "upgrade" ":no-tests"]
                 "ultra" ["with-profile" "+ultra" "repl"]}}
 :injections {:dependencies [[spyscope "0.1.5"]
                             [im.chit/vinyasa "0.4.7"]
                             [io.aviso/pretty "0.1.30"]
                             [clj-time "0.12.0"]]
              :injections [(require 'spyscope.core)
                           (require '[vinyasa.inject :as inject])
                           (require 'io.aviso.repl)
                           (io.aviso.repl/install-pretty-exceptions)
                           (inject/in
                                  [vinyasa.inject :refer [inject [in inject-in]]]
                                  [vinyasa.maven pull]

                                  clojure.core
                                  [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]

                                  clojure.core >
                                  [clojure.pprint pprint])]}
 :ultra {:plugins [[venantius/ultra "0.4.1"]]
         :ultra {:color-scheme :solarized_dark}}
 :dox {:plugins [[me.raynes/dox "0.1.0"]]}
 :user [:xsc :injections]}
