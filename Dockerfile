FROM vady1/rails-app:latest

RUN cd /opt/app/cassandra-example-using-rails && git pull origin master

RUN cd /opt/app/cassandra-example-using-rails && bundle install

COPY cequel.yml /opt/app/cassandra-example-using-rails/config/

COPY routes.rb /opt/app/cassandra-example-using-rails/config/

COPY post.rb  /opt/app/cassandra-example-using-rails/app/models

COPY development.rb  /opt/app/cassandra-example-using-rails/config/environments/

COPY webpacker.yml /opt/app/cassandra-example-using-rails/config

CMD /opt/app/cassandra-example-using-rails/run.sh
