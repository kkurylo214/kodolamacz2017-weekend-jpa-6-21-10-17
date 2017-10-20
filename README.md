Instalacja docker
---
Ubuntu <br>
https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu <br>

Mac <br>
https://docs.docker.com/docker-for-mac/install <br>

64bit Windows 10 Pro <br>
https://docs.docker.com/docker-for-windows/install <br>

Inne Windows'y <br>
https://docs.docker.com/toolbox/toolbox_install_windows <br>

Gdzie szukać obrazów docker
---
Oficjalny, domyślny rejestr docker <br>
https://hub.docker.com <br>

Np. obraz postgres <br>
https://hub.docker.com/_/postgres <br>

Podstawowe komendy docker
---
**Utworzenie i wystartowanie kontenera** <br>
`docker run --name test-postgres -d -p 5555:5432 postgres:9.6` <br>
Tworzy kontener postgresa o nazwie `test-postgres` w wersji `9.6` chodzący w tle (flaga `-d`). <br>
Port `5432` otwarty wewnątrz kontenera jest mapowany na port `5555` dostępny na localhost (flaga `-p 5555:5432`). <br>
Można teraz połączyć się do postgresa `psql -U postgres -h localhost -p 5555`. <br>

**Zatrzymanie kontenera** <br>
`docker stop test-postgres` <br>
Zatrzymuje kontener o nazwie `test-postgres`. <br>
Teraz połączenie do postgresa się nie uda. <br>

**Wyświetlenie wystartowanych kontenerów** <br>
`docker ps` <br>

**Wyświetlenie wystartowanych i zatrzymanych kontenerów** <br>
`docker ps -a` <br>

**Usunięcie zatrzymanego kontenera** <br>
`docker rm test-postgres` <br>

**Usunięcie wystartowanego lub zatrzymanego kontenera** <br>
`docker rm -f test-postgres` <br>

**Usunięcie wystartowanego lub zatrzymanego kontenera** <br>
`docker rm -f test-postgres` <br>

**Usunięcie obrazu** <br>
`docker rmi postgres:9.6` <br>

**Wyświetl log kontenera** <br>
`docker logs test-postgres` <br>

**Wyświetl log kontenera i podążaj za logiem** <br>
`docker logs -f test-postgres` <br>

**Wyczyszczenie nieużywanych obrazów, kontenerów i sieci** <br>
Docker potrafi pochłonąć dużo pamięci na dysku, czasem pojawia się potrzeba wyczyszczenia zasobów. <br>
Wiszące sieci docker potrafią powodować konflikty ip. <br>
`docker image prune` <br>
`docker container prune` <br>
`docker network prune` <br>

**Odpalenie komendy na kontenerze** <br>
`docker exec -it test-postgres /bin/bash` <br>
Startuje konsolę kontenera `test-postgres`. <br>

Instalacja docker compose
---
https://docs.docker.com/compose/install <br>
Docker compose pozwala na zapisanie do pliku zestawu kontenerów i ich konfiguracji. <br>
Czasami musimy odpalić wiele kontenerów ze skomplikowaną konfiguracją, dzięki docker compose można tę czynność zautomatyzować. <br>

Docker compose
---
Konfigurację kontenerów umieszcza się w pliku *docker-compose.yml*.

*docker-compose.yml*
```yaml
version: '3'

networks:
   backend:

services:
   test-mongo:
      image: mongo:3.4
      container_name: test-mongo
      ports:
        - "27017:27017"
      networks:
        backend:
          aliases:
            - mongodb
        
   test-restheart:
      image: softinstigate/restheart:3.1.3
      container_name: test-restheart
      depends_on:
         - test-mongo
      ports:
         - "8080:8080"
      networks:
        - backend
```
