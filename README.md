# docker-dev.artifactory.service.altiscale.com/hello-sap-jupyter

A tiny docker image to print `Hello SAP BDS Jupyter!` and other info
to the console.

# How to run it

In dev environment,
```
docker run --rm docker-dev.artifactory.service.altiscale.com/hello-sap-jupyter:linux
```

In prod environment,
```
docker run --rm docker-prod.artifactory.service.altiscale.com/hello-sap-jupyter:linux
```

# Build and publish
Run it on a Linux box (e.g. CentOS 6.7)
```
update.sh
```
and you will see 2 images produced. Only publish the real one `hello-sap-jupyter:test-hello-world`,
not the one with the build environment.
```
REPOSITORY                                                            TAG                 IMAGE ID            CREATED             SIZE
hello-sap-jupyter                                                     build               2a8f54b5f57d        17 minutes ago      214 MB
hello-sap-jupyter                                                     test-hello-world    db659293db77        17 minutes ago      1.86 kB
```
Publishing the image to internal repository. Keep in mind that we will only have one tag `linux`
here and won't be maintaining multiple tars for different architecture. IF you want to support
a different type of architecture, you will need to extend the build process, etc.
```
# Delete the build environment so you don't publish the incorrect image
docker rmi -f 2a8f54b5f57d
docker tag hello-sap-jupyter:test-hello-world docker-dev.artifactory.service.altiscale.com/hello-sap-jupyter:linux
docker push docker-dev.artifactory.service.altiscale.com/hello-sap-jupyter:linux
docker tag hello-sap-jupyter:test-hello-world docker-dev.artifactory.service.altiscale.com/hello-sap-jupyter:latest
docker push docker-dev.artifactory.service.altiscale.com/hello-sap-jupyter:latest
```
