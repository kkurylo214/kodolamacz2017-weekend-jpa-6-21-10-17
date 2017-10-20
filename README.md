Analiza statyczna - checkstyle
---
Pomaga utrzymać spójność stylu w kodzie. <br>

Konfiguracja w pliku *checkstyle.xml* <br>

Wzorcowe konfiguracje: <br>
sun style: https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/sun_checks.xml <br>
google style: https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml <br>

Plugin CheckStyle-IDEA <br>

```xml
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-checkstyle-plugin</artifactId>
        <version>2.17</version>
        <dependencies>
          <dependency>
            <groupId>com.puppycrawl.tools</groupId>
            <artifactId>checkstyle</artifactId>
            <version>8.2</version>
          </dependency>
        </dependencies>
        <configuration>
          <configLocation>checkstyle.xml</configLocation>
          <encoding>UTF-8</encoding>
          <consoleOutput>true</consoleOutput>
          <failsOnError>true</failsOnError>
        </configuration>
        <executions>
          <execution>
            <id>checkstyle</id>
            <phase>verify</phase>
            <goals>
              <goal>check</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
```

Analiza statyczna - Sonar
---
Kompleksowa analiza statyczna i raportowanie. <br>

Obraz dockerowy: https://hub.docker.com/_/sonarqube <br>

Start sonara: <br>
`docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube:6.5`

Odpalenie sonara: <br>
`mvn verify` <br>
`mvn verify -Dsonar.host.url=http://192.168.2.168:9000` <br>

```xml
  <build>
    <plugins>
      <plugin>
        <groupId>org.sonarsource.scanner.maven</groupId>
        <artifactId>sonar-maven-plugin</artifactId>
        <version>3.3.0.603</version>
        <executions>
          <execution>
            <id>sonar</id>
            <phase>verify</phase>
            <goals>
              <goal>sonar</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
```

Analiza statyczna - JaCoCo
---
Liczy pokrycie kodu testami. <br>

---
```xml
  <build>
    <plugins>
      <plugin>
        <groupId>org.jacoco</groupId>
        <artifactId>jacoco-maven-plugin</artifactId>
        <version>0.7.9</version>
        <executions>
          <execution>
            <id>prepare-agent</id>
            <goals>
              <goal>prepare-agent</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
```

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

**Wyświetlenie pobranych obrazów** <br>
`docker images` <br>

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

**Wystartowanie konfiguracji** <br>
`docker-compose up -d` <br>

**Zatrzymanie konfiguracji** <br>
`docker-compose stop` <br>

Definiowanie obrazów docker
---
Obrazy definiuje się w pliku *Dockerfile*. <br>
Dokumentacja *Dockerfile*: https://docs.docker.com/engine/reference/builder <br>

*Dockerfile*
```dockerfile
FROM java:8-jre-alpine

COPY test-app.jar /test-app/test-app.jar

ENTRYPOINT java -jar /test-app/test-app.jar
```

**Zbudowanie obrazu** <br>
`docker build -t test-app:1.0 .` <br>

**Pro Tip - budowanie wykonywalnego jar** <br>
https://stackoverflow.com/a/574650 <br>
`mvn clean compile assembly:single` <br>

Mongo
---
Obraz: https://hub.docker.com/_/mongo <br>

Klient mongo: https://docs.mongodb.com/getting-started/shell/installation <br>

**Postawienie mongo** <br>
`docker run -d -p 27017:27017 --name mongo mongo` <br>

**Podpięcie do mongo** <br>
`mongo` <br>

**Wybranie bazy** <br>
`use test-db` <br>

**Utworzenie kolekcji** <br>
`db.createCollection('test')` <br>

**Wyświetl kolekcje** <br>
`db.getCollectionNames()` <br>
`show collections` <br>

**Wyświetl bazy** <br>
`show databases` <br>

**Umieść dokument** <br>
`db.test.insert({"test-key": 3})` <br>

**Wyświetl wszystkie dokumenty** <br>
`db.test.find({})` <br>

**Wyświetl wybrane dokumenty** <br>
`db.test.find({"test-key": {$gt: 2}})` <br>

**Modyfikuj dokument** <br>
`db.test.update({"_id": ObjectId("59ea60f491cc82d8272001bc")},{"test-key": 4})` <br>

Zadanie 1
------
Napisz aplikację, która wrzuca co sekundę do bazy jakiś: <br>
Shop
* name
* address

Utwórz obraz twojej aplikacji (Dockerfile). <br>

Utwórz docker compose z postgresem i twoją aplikacją (docker-compose.yml). <br>
Wystaw port postgresa na zewnątrz (5432), żeby obejrzeć zmiany w bazie. <br>

Zadanie 2
------

1. Stwórz aplikację pozwalającą na umieszczanie w mongo sklepów i ją zdokeryzuj. <br>

```json
{
  "id": "some-shop",
  "products": [
    {
      "id": "some-product",
      "price": 10
    }
  ]
}
```
