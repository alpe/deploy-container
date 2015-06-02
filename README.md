## Deploy container
Containerized environment to configure/ deploy to staging.

## Build
~~~bash
docker build -t deploy_image .
~~~
* Connect manual to container
~~~
docker run --rm -i -t deploy_image /bin/bash
~~~
