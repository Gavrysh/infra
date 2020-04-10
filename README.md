# infra
инфрастурктурный репозиторий

gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-project=ubuntu-os-cloud \
--image=ubuntu-1604-xenial-v20200407 \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west1-b

