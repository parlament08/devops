# DevOps-проект: Автоматизация деплоя Flask + мониторинг с Grafana

## 📌 Цель проекта

Полностью автоматизировать деплой Flask-приложения на Google Cloud VM с помощью:

- Terraform (создание инфраструктуры)
- Ansible (настройка сервера и Docker)
- Jenkins (CI/CD по коммиту в GitHub)
- Prometheus + Grafana (сбор метрик и мониторинг)

---

## ⚙️ Технологии

| Компонент     | Назначение                        |
|---------------|-----------------------------------|
| Terraform     | Создание VM, firewall, SSH        |
| Ansible       | Установка Docker, запуск сервисов |
| Jenkins       | CI/CD pipeline                    |
| Docker        | Flask-приложение, Prometheus, Grafana |
| Prometheus    | Сбор системных метрик             |
| Grafana       | Визуализация метрик               |

---

## 📁 Структура проекта

```plaintext
.
├── app/                       # Flask-приложение
│   ├── app.py
│   └── Dockerfile
├── ansible/
│   ├── playbook.yml
│   └── files/
│       ├── prometheus.yml
│       └── sample-dashboard.json
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
├── inventory.ini             # Генерируется автоматически
├── Jenkinsfile               # CI/CD pipeline
├── setup.sh                  # Автоматизация запуска
└── README.md
```


---

## 🚀 Быстрый старт

### 1. Подготовка

- Установи: `Terraform`, `Ansible`, `Docker`, `Jenkins`
- Убедись, что у тебя есть SSH-ключ и доступ к GCP

### 2. Запуск

```bash
chmod +x setup.sh
./setup.sh
