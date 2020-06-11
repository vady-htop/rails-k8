FROM vady1/rails-app:latest

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser


RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update  && apt-get install -y \
    vim \
    nodejs \
    yarn


RUN cd /opt/app/ && git clone https://github.com/conradwt/cassandra-example-using-rails.git && rm cassandra-example-using-rails/config/webpacker.yml

RUN cd /opt/app/cassandra-example-using-rails && bundle install

COPY cequel.yml /opt/app/cassandra-example-using-rails/config/

COPY routes.rb /opt/app/cassandra-example-using-rails/config/

COPY post.rb  /opt/app/cassandra-example-using-rails/app/models

COPY run.sh /opt/app/cassandra-example-using-rails

RUN rails cequel:keyspace:create && rails cequel:migrate

RUN chmod +x /opt/app/cassandra-example-using-rails/run.sh

RUN chown -R appuser:appuser /opt/app

USER appuser

WORKDIR /opt/app/cassandra-example-using-rails

CMD /opt/app/cassandra-example-using-rails/run.sh
