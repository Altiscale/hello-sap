#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x

docker build -f Dockerfile.build -t hello-sap-jupyter:build .

rm -rf */hello */nanoserver*/hello.txt
docker run --rm hello-sap-jupyter:build sh -c 'find \( -name hello -or -name hello.txt \) -print0 | xargs -0 tar --create' | tar --extract --verbose

for h in amd64/*/hello; do
	d="$(dirname "$h")"
	b="$(basename "$d")"
	"$h" > /dev/null
	docker build -t hello-sap-jupyter:"test-$b" "$d"
	docker run --rm hello-sap-jupyter:"test-$b"
done
ls -lh */*/{hello,nanoserver*/hello.txt} || :
