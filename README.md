# infra
# инфрастурктурный репозиторий

```
gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-project=ubuntu-os-cloud \
--image=ubuntu-1604-xenial-v20200407 \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west1-b \
--metadata-from-file startup-script=startup.sh
```

Скрипт отрабатывает только от *root* (особенность gcloud)

## Unit 9
Создать образы с помощью **packer** на основе `infra/packer/app.json` и `infra/packer/db.json`

Определить переменные
* project
* public_key_path
* private_key_path
* app_disk_image
* db_disk_image
в файле `terraform.tfvars`

Перейти в каталог `infra/terraform` выполнить
```
$ terraform init
$ terraform plan
$ terraform apply
```

Также рабочими являются каталоги `stage` и `prod` внутри которых отрабатывает **terraform**
После проверки работоспособности необходимо выполнить команду
```
$ terraform destroy
```
## Unit 10
Созданы *playbooks* для **app** и **db** (`ansible/reddit_app.yml`, `ansible/reddit_db.yml`) которые можно проверить командами
```
$ ansible-playbook -u appuser -i <IP instance>, reddit_app.yml
$ ansible-playbook -u appuser -i <IP instance>, reddit_db.yml
```
Взаимодействие *playbooks* с **packer** выполнена отдельными файлами - `packer/app.json` и `packer/db.json`

## Unit 11
Базовые инстансы создаются **packer** на основе *playbooks* `ansible/packer_reddit_app.yml`, `ansible/packer_reddit_db.yml`
Далее в каталоге `infra/terraform/` при наличии файла `terraform.tfvars` в котором определены переменные:
* project
* public_key_path
* private_key_path
* app_disk_image
* db_disk_image
выполнить команды
```
$ terraform init
$ terraform plan
$ terraform apply
```
Перейти в каталог `infra/ansible` и внести IP-адреса созданных **terraform** инстансов в файл `hosts`
Проверить доступность хостов командой
```
$ ansible all -m ping
```
Применить *playbook* к группе хостов **db** предварительно проверив (параметр `--check`)
```
$ ansible-playbook reddit_app.yml --limit db --check
$ ansible-playbook reddit_app.yml --limit db
```
В *playbook* определить переменную `db_host` которая соответствует внутреннему IP инстанса базы данных.
Выполнить пробный прогон и при отсутствии ошибок применить таски плейбука с тегом `app-tag` для группы хостов **app**
```
$ ansible-playbook reddit_app.yml --limit app --tags app-tag --check
$ ansible-playbook reddit_app.yml --limit app --tags app-tag
```
Сделать проверку деплоя и, при отсутствии ошибок применяем таски плейбука с тегом `deploy-tag` для группы хостов **app**
```
$ ansible-playbook reddit_app.yml --limit app --tags deploy-tag --check
$ ansible-playbook reddit_app.yml --limit app --tags deploy-tag
```
Выполнить проверку приложения в браузере
<Internal IP app>:9292

После проверки работоспособности необходимо выполнить команду
```
$ terraform destroy
```
