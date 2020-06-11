FROM bitnami/ruby:latest

RUN mkdir /opt/app

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser

RUN chown -R appuser:appuser /opt/app

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update  && apt-get install -y \
    vim \
    nodejs \
    yarn \
    gnupg2

RUN cd /opt/app/ && \
    gem install rails && \
    rails new blog ---skip-active-record --skip-active-storage -T --skip-bundle && \
    cd /opt/app/blog && bundle install  && \ 
    bundle add cequel && \
    bundle add activemodel-serializers-xml && \
    rails g scaffold post title body 

COPY cequel.yml /opt/app/blog/config/ 
COPY routes.rb /opt/app/blog/config/ 
COPY post.rb  /opt/app/blog/app/models/

RUN rails cequel:keyspace:create && rails cequel:migrate

RUN cd /opt/app/blog && bundle exec rails webpacker:install
USER appuser

WORKDIR /opt/app/blog

CMD ["rails", "server", "-b", "0.0.0.0"]


