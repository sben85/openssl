openssl req -x509 \
            -sha256 -days 30000 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=dsc-sealfactory/O=Yettel/C=HU/L=Budapest" \
            -keyout infra-root.key -out infra-root.crt 


openssl genrsa -out dsc-sealfactory.key 2048
openssl req -new -key dsc-sealfactory.key -out dsc-sealfactory.csr -config config/csr.conf


openssl x509 -req \
    -in dsc-sealfactory.csr \
    -CA infra-root.crt -CAkey infra-root.key \
    -CAcreateserial -out dsc-sealfactory.crt \
    -days 30000 \
    -sha256 -extfile config/cert.conf

openssl pkcs12 -export -inkey dsc-sealfactory.key -in dsc-sealfactory.crt -out dsc-sealfactory.p12 -name dsc-sealfactory -passout pass:1111

