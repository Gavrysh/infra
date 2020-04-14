# infra
# инфрастурктурный репозиторий

`gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-project=ubuntu-os-cloud \
--image=ubuntu-1604-xenial-v20200407 \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west1-b \
--metadata-from-file startup-script=startup.sh`

Скрипт отрабатывает только от root (особенность gcloud)

## Unit 9
Определить переменные
* project
* public_key_path
* private_key_path
* app_disk_image
* db_disk_image
в файле `terraform.tfvars`

Перейти в каталог terraform  выполнить
```
$ terraform init
$ terraform plan
$ terraform apply
```
