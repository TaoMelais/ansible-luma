# Installation Grafana sur Container Proxmox

```shell
wget -qO- https://raw.githubusercontent.com/TaoMelais/ansible-luma/refs/heads/main/grafana/script_install.sh | sh
```

# Installation Prometheus sur Container Proxmox

```shell
wget -qO- https://raw.githubusercontent.com/TaoMelais/ansible-luma/refs/heads/main/prometheus/script_install.sh | sh
```

# Installation Loki sur Container Proxmox

```shell
wget -qO- https://raw.githubusercontent.com/TaoMelais/ansible-luma/refs/heads/main/loki/script_install.sh | sh
```

# Installation Promtail sur Container Proxmox

```shell
apt update
apt upgrade -y
apt install curl -y
curl -o script_install.sh https://raw.githubusercontent.com/TaoMelais/ansible-luma/refs/heads/main/promtail/script_install.sh
. script_install.sh
```


# Fonctionnement

Récupération de script_install.sh depuis github via curl.
Il execute le script_install.sh.

Le script_install.sh va :
    - installer des dépendances
    - configurer la locale
    - cloner le repo ansible
    - creer un .env
    - execute install_grafana.yml avec ansible