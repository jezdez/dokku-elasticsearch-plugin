Elasticsearch plugin for Dokku
------------------------------

Project: https://github.com/progrium/dokku

Installation
------------
```
cd /var/lib/dokku/plugins
git clone https://github.com/jezdez/dokku-elasticsearch-plugin elasticsearch
dokku plugins-install
```

This plugin also requires the dokku-link plugin to be installed:
https://github.com/rlaneve/dokku-link

It uses the excellent Elasticsearch docker image by the people at Orchard
( https://orchardup.com/ ): https://github.com/orchardup/docker-elasticsearch

Commands
--------
```
$ dokku help
     elasticsearch:create <app>            Create a Elasticsearch container
     elasticsearch:delete <app>            Delete specified Elasticsearch container
     elasticsearch:info <app>              Display container informations
     elasticsearch:link <app> <container>  Link an app to a Elasticsearch container
     elasticsearch:logs <app>              Display last logs from Elasticsearch container
```

Simple usage
------------

Create a new Container:
```
$ dokku elasticsearch:create foo            # Server side
$ ssh dokku@server elasticsearch:create foo # Client side

-----> Elasticsearch container created: elasticsearch/foo

       Host: 172.16.0.104
       Private ports: 9200, 9300
```

Advanced usage
--------------

Deleting containers:
```
dokku elasticsearch:delete foo
```

Linking an app to a specific container:
```
dokku elasticsearch:link foo bar
```

Elasticsearch logs (per container):
```
dokku elasticsearch:logs foo
```

Elasticsearch information:
```
dokku elasticsearch:info foo
```
