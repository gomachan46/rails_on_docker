FROM centos:7

# install runtime

RUN yum update -y \
    && yum install -y gcc bzip2 openssl-devel libyaml-devel libffi-devel \
    readline-devel zlib-devel \
    gdbm-devel ncurses-devel make sqlite-devel \
    gcc-c++ nc mysql-devel postgresql-devel \
    git curl wget vim sudo zsh mysql \
    && yum clean all;

# install google-chrome
ADD ./google-chrome.repo /etc/yum.repos.d/google-chrome.repo
RUN yum install -y google-chrome-stable mesa-libOSMesa mesa-libOSMesa-devel ibus-kkc vlgothic-* \
    && ln -s /usr/lib64/libOSMesa.so.8.0.0 /opt/google/chrome/libosmesa.so \
    && yum clean all;

# install nodejs
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - \
    && yum -y install nodejs \
    && yum clean all;

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN git clone git://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

ENV PATH /root/.rbenv/bin:$PATH
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
RUN echo '-T --skip-bundle' >> ~/.railsrc

ENV CONFIGURE_OPTS --disable-install-rdoc
ENV RUBY_CONFIGURE_OPTS --with-readline-dir=/usr/lib
RUN rbenv install 2.4.3
RUN rbenv global 2.4.3
RUN /bin/bash -l -c 'gem install bundler'

ENV APP_DIR_NAME myapp

ADD ./scripts /root/scripts
RUN chmod -R +x /root/scripts

# RUN yum -y reinstall glibc-common
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_ALL="ja_JP.UTF-8"
ENV LC_CTYPE="ja_JP.UTF-8"
ENV COMMAND /bin/bash
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN mkdir -p /var/log/${APP_DIR_NAME}
RUN echo "export PATH=/root/${APP_DIR_NAME}"/bin:'${PATH}' >> ~/.bashrc

WORKDIR /root/${APP_DIR_NAME}

CMD [ "/root/scripts/start.sh" ]
