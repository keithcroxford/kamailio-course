#Creating the self signed certificate


```bash
openssl genpkey -algorithm RSA -out private_key.pem
openssl req -new -key private_key.pem -out certificate.csr
openssl x509 -req -in certificate.csr -signkey private_key.pem -out self_signed_certificate.pem
```

# Explaination 

```bash
openssl genpkey -algorithm RSA -out private_key.pem
```
OpenSSL command used to generate a private key in the PEM format using the RSA algorithm
openssl: This is the command-line tool for using the OpenSSL library, which provides cryptographic functions and utilities.

genpkey: This specific OpenSSL command is used for generating private keys.
-algorithm RSA: Specifies the algorithm to be used for key generation, in this case, RSA.
-out private_key.pem: Specifies the output file where the generated private key will be saved. In this example, the private key is saved in a file named "private_key.pem" in PEM format.


```bash
openssl req -new -key private_key.pem -out certificate.csr
```

This OpenSSL command is used to generate a Certificate Signing Request (CSR) using an existing private key. Here's a breakdown of the command:

openssl: The command-line tool for OpenSSL.
req: This is the OpenSSL command for creating and processing certificate requests.
-new: Specifies that a new CSR should be generated.
-key private_key.pem: Specifies the private key file to be used for generating the CSR. In this case, it uses the private key stored in the "private_key.pem" file.
-out certificate.csr: Specifies the output file where the generated CSR will be saved. In this example, the CSR is saved in a file named "certificate.csr."

A CSR is a request sent to a Certificate Authority (CA) to apply for a digital certificate. The CSR contains information about the entity (such as a website) that is requesting the certificate and the public key that will be included in the certificate. Once you have the CSR, you typically submit it to a CA, and they will issue a digital certificate based on the information provided in the CSR.

```bash
openssl x509 -req -in certificate.csr -signkey private_key.pem -out self_signed_certificate.pem
```

This OpenSSL command is used to sign a Certificate Signing Request (CSR) with a private key to generate a self-signed X.509 certificate. Here's a breakdown of the command:
openssl: The command-line tool for OpenSSL.

x509: This is the OpenSSL command for working with X.509 certificates.
-req: Indicates that the input file is a Certificate Signing Request (CSR).
-in certificate.csr: Specifies the input file, which is the CSR file you generated earlier.
-signkey private_key.pem: Specifies the private key file to sign the CSR and generate the certificate. The private key from "private_key.pem" is used for signing.
-out self_signed_certificate.pem: Specifies the output file where the self-signed X.509 certificate will be saved. In this example, it is saved in a file named "self_signed_certificate.pem."

This command essentially takes a CSR, signs it with the private key, and produces a self-signed certificate. Self-signed certificates are certificates where the entity generating the certificate is also the one signing it. While self-signed certificates can be used for testing or internal purposes, they are not commonly used in production environments because they lack the validation provided by certificates signed by a trusted Certificate Authority (CA).

