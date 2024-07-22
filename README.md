

## Usage


1 - Build the docker container by executing:
`sh dockerbuild.sh`

2 - Run the container by executing:
`sh dockerrun.sh`

This will run the container and mount the current directory as /workdir. This filepathing is critical for the tabpy configuration file

# All commands, unless otherwise stated must be executed from inside the container

3 - create a credentials directory:
`mkdir credentials`

3 - Generate SSL certifcates by executing:

3a - `openssl genpkey -algorithm RSA -out /workdir/credentials/sample_key.key -pkeyopt rsa_keygen_bits:2048`

3b - `openssl req -new -key /workdir/credentials/sample_key.key -out /workdir/credentials/sample_cert.csr`

3c - `openssl req -x509 -key /workdir/credentials/sample_key.key -in /workdir/credentials/sample_cert.csr -out /workdir/credentials/sample_cert.crt`

Follow all prompts on step 3b

4 - Add credentials by executing:
`tabpy-user add -u testuser -p t3st-pw -f /workdir/credentials/sample_password.txt`

5 - Run the tabpy server by executing:
`sh run_tabpy.sh`

This bash script runs tabpy with the settings on the `/workdir/_conf.conf` file, which specify certificates and credentials.

More information on server configuration: https://github.com/tableau/TabPy/blob/master/docs/server-config.md

## Notes / Issues
Special notes on SSL issues

Tableau cloud appears to absolutely require SSL certificates registered to a "3rd party certificate authority" and a url that is on the actual internet.
localhost will not work with Tableau Cloud.

http seems to work with tableau server (running on own network):
 https://help.tableau.com/current/server/en-us/ssl_config.htm

 https://help.tableau.com/current/server/en-us/config_r_tabpy.htm#server-ssl

Editing the `_conf.conf` file to use http will run properly and might work on tableau server, assuming this container (running tabpy) are running on the same machine hosting the tableau server:

```TABPY_TRANSFER_PROTOCOL = http```

## Verifying certificates

`openssl x509 -in /workdir/credentials/sample_cert.crt -text -noout`

`openssl x509 -noout -modulus -in /workdir/credentials/sample_cert.crt | openssl md5`

`openssl rsa -noout -modulus -in /workdir/credentials/sample_key.key | openssl md5`

