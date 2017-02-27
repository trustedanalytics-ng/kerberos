docker build -t localhost:krbbuildagent -f Dockerfile .
docker run -it -d localhost:krbbuildagent /bin/bash
export container=`docker ps | grep localhost:krbbuildagent | cut -d" " -f1 | head -1`
echo "container - $container"
echo "running compilation"
echo "container : $container"

docker exec -t $container sh -c '(cd /kerberos/src/ && util/reconf --force)'
docker exec -t $container sh -c '(cd /kerberos/src/ && ./configure --prefix=/usr --exec-prefix=/usr --localstatedir=/var/kerberos && make all)'
docker exec -t $container sh -c '(cd /kerberos/src/ && mkdir /KRB_DESTDIR &&  make install DESTDIR=/KRB_DESTDIR)'
docker cp $container:/KRB_DESTDIR/ KRB_DESTDIR
cd KRB_DESTDIR; zip -r ../kerberos-jwt-1.13.7-el7-x86_64.zip .
