{:xsc {:plugins [[lein-ancient "1.0.0-RC4-SNAPSHOT"]
                 #_[lein-try "0.4.3"]
                 [lein-license "1.0.0"]]
       :deploy-repositories
       [["releases" {:url "https://repo.clojars.org", :creds :gpg}]
        ["snapshots" {:url "https://repo.clojars.org", :creds :gpg}]]
       :signing {:gpg-key "ED4FB884"}
       :aliases {"qi" ["ancient" "upgrade" ":no-tests" ":interactive"]
                 "q"  ["ancient" "upgrade" ":no-tests"]}}
 :iced {:pedantic? :warn}
 :user [:xsc]}
