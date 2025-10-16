# From Pipeline to Ingress

This repo demonstrates containerizing, building, deploying and exposing an example app.

## The journey:

```shell
git log --all --decorate --oneline --graph
```

### part 1: just an app

The app runs locally, in your shell or IDE

```shell
mvn clean spring-boot:run
```

### part 2: containerization

The app runs in local docker.

```shell
docker build -t cijug . && docker run -p 8080:8080 --rm cijug
```

### part 3: automation

The app builds and runs tests on github actions.

https://github.com/AndreasChristianson/pipeline-to-ingress/actions/workflows/deploy.yaml

### part 4: container repository

The app image builds and is pushed to a repository.

https://github.com/AndreasChristianson/pipeline-to-ingress/pkgs/container/pipeline-to-ingress

```shell
docker run --rm -p 8080:8080 ghcr.io/andreaschristianson/pipeline-to-ingress:latest
```

### part 5: k8s access

We can access the kubernetes cluster from github actions.

```shell
kubectl apply -f namespace.yaml                                                                                                                                                                                                 ⏎ ✹ ✭
kubectl apply -f service-account.yaml
./create-kube-config.sh glowbox.pessimistic-it.com
```

Place generated kube config in a repo secret named KUBE_CONFIG.

### part 6: Deploy to k8s

The deployment is rolled out to k8s.

```shell
kubectl get -n cijug pods
kubectl port-forward -n cijug deployments/cijug 8080
```

### part 7: Expose the service

The deployment is visible at http://cijug.dev.pessimistic-it.com

```shell
open http://cijug.dev.pessimistic-it.com
```

## Bonus topics

### Private ghcr access

### Ingress path munging