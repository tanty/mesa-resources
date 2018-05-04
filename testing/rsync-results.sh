#!/bin/bash

if [ "x$1" = "x"]; then
   echo "Syntax error"
   exit -1
fi

if [ "x$2" = "x"]; then
   echo "Syntax error"
   exit -2
fi

mkdir "$1"
cd "$1"

CTS="$1"; for i in baltix panix pacifix elastix; do mkdir $i; cd $i; rsync -avzh --progress $i.local.igalia.com:ci/piglit-results/cts-runner/${CTS}* .; cd -; done
cp -a ../fill-twiki-table-column.sh .
cp -a ../get-results.sh .
cp -a ../clean-twiki-table.sh .
cp -a ../generate-twiki-table.sh .

cd -

mkdir "$2"
cd "$2"

CTS="$2"; for i in baltix panix pacifix elastix; do mkdir $i; cd $i; rsync -avzh --progress $i.local.igalia.com:ci/piglit-results/cts-runner/${CTS}* .; cd -; done
cp -a ../fill-twiki-table-column.sh .
cp -a ../get-results.sh .
cp -a ../clean-twiki-table.sh .
cp -a ../generate-twiki-table.sh .

cd -

tar cJpf ${$1%%-*}.tar.xz $1
tar cJpf ${$2%%-*}.tar.xz $2
