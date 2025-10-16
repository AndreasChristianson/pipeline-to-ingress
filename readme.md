# From Pipeline to Ingress

This repo demonstrates containerizing, building, deploying and exposing an example app.

## part 1: just an app

```shell
mvn clean spring-boot:run
```

## part 2: containerization

```shell
docker build -t cijug . && docker run -p 8080:8080 --rm cijug
```

## part 3: automation



