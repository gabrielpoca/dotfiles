#!/usr/bin/env ruby

result=`kubectl get pods --all-namespaces | fzf`.split(" ").map(&:strip)

command = "kubectl -n #{result[0]} exec -it #{result[1]} -- bash"

system(command)

