# DevOps Project: Automating Flask Deployment + Monitoring with Grafana

## Project Goal

Fully automate the deployment of a Flask application on a Google Cloud VM using:

- Terraform (infrastructure creation)
- Ansible (server and Docker setup)
- Jenkins (CI/CD triggered by GitHub commits)
- Prometheus + Grafana (metrics collection and monitoring)

---

## Technologies

| Component  | Purpose                                 |
|------------|-----------------------------------------|
| Terraform  | Create VM, firewall, SSH                |
| Ansible    | Install Docker, launch services         |
| Jenkins    | CI/CD pipeline                          |
| Docker     | Flask application, Prometheus, Grafana  |
| Prometheus | Collect system metrics                  |
| Grafana    | Visualize metrics                       |

---

## Project Structure

```plaintext
.
├── app/                       # Flask-application
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── ansible/
│   ├── playbook.yml
│   └── files/
│       ├── prometheus.yml
│       └── sample-dashboard.json
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
├── inventory.ini             # Generated automatically
├── Jenkinsfile               # CI/CD pipeline
├── setup.sh                  # automation of startup
└── README.md
```


---

## Quick Start

### 1. Prepare

- Install: `Terraform`, `Ansible`, `Docker`, `Jenkins`
- Make sure you have an SSH key and access to GCP

### 2. Start

```bash
chmod +x setup.sh
./setup.sh
