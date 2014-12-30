# Logstash Dockerfile

Logstash 1.4.2

Pull from the Hub:

    docker pull denibertovic/logstash

First we need to make sure Elasticsearch is running

    docker run --name elasticsearch -d -t denibertovic/elasticsearch

Run logstash:

    docker run --name logstash -p 5043:5043 -p 514:514 -v `pwd`/certs:/opt/certs \
        -v `pwd`/conf-example:/opt/conf --link elasticsearch:elasticsearch -i -t denibertovic/logstash

Once the service is running try and send some data to it with netcat:

    netcat localhost 514
        > test
        > test
        > CTRL+C
    # You should see the messages show up on logstash

Ports

    514  (syslog)
    5043 (lumberjack)
    9292 (logstash ui)

Volumes

    /opt/conf (contains logstash.conf)
    /opt/certs (contains logstash forwarder certificates)

