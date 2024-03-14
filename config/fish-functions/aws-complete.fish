function aws-complete --description "custom completer function from chatgpt"
  set -lx COMP_LINE (commandline -cp)
  set -lx COMP_POINT (commandline -cp | string length)
  /usr/local/bin/aws_completer
end
