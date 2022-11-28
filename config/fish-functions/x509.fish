function x509 --wraps='openssl x509' --description='openssl x509 no frills'
    command openssl x509 -noout -text -certopt no_pubkey,no_sigdump,no_version,no_serial,no_signame $argv;
end
