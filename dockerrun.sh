# #!/bin/bash

docker run -it \
           --name tabpy-admin \
           --rm \
           -v ${PWD}:/workdir \
           --workdir=/workdir \
           -p 9004:9004 \
           tabpy-admin
