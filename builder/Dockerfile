FROM moog/c7-systemd:latest
ENV container docker
RUN yum install -y gcc wget make curl-devel expat-devel \
               gettext-devel openssl-devel perl-devel zlib-devel \
               gzip bzip2 gcc-gnat texinfo file gcc-c++ flex \
               autoconf automake ncurses-dev libtool python3
RUN cd ~; mkdir gcc_build;
RUN cd ~/gcc_build; git clone https://github.com/gcc-mirror/gcc
RUN cd ~/gcc_build/gcc; ./contrib/download_prerequisites

# Yet another tool missing is make.
# Stock Centos 7 Can't do the latest make (4.3) as that needs a newer autoconf than exists
# in Centos 7 - We'd either have to build it from scratch or upgrade to Centos 8
# 3rd party automake is required.

RUN cd /etc/yum.repos.d && wget https://download.opensuse.org/repositories/home:jayvdb:autotools/CentOS_7/home:jayvdb:autotools.repo
RUN cd /etc/yum.repos.d yum install -y automake


VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
