FROM centos:7.2.1511
RUN yum groupinstall -y "Development tools"
RUN yum install -y openssl-devel
RUN curl http://dl.fedoraproject.org/pub/epel/7/x86_64/h/hardening-check-2.5-1.el7.noarch.rpm -o hardening-check-2.5-1.el7.noarch.rpm ; rpm -Uv hardening-check-2.5-1.el7.noarch.rpm
COPY . /kerberos
ENV CFLAGS "-O2 -D_FORTIFY_SOURCE=2 -fstack-protector -Wformat -Wformat-security -fPIE -fPIC"
ENV LDFLAGS ""
