function kctx --wraps='kubectl config use-context' --description='switch kubectl contexts'
  command kubectl config use-context $argv
end
