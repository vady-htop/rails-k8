FROM vady1/rails-app:latest

RUN cd /opt/app/cassandra-example-using-rails && git pull origin master 

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
