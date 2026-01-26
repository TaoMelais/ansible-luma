# Installation Grafana sur Container Proxmox

apt update
apt upgrade -y
apt install curl -y
curl -o script_install.sh https://raw.githubusercontent.com/TaoMelais/ansible-luma/refs/heads/main/script_install.sh
. script_install.sh


# Installation Prometheus sur Container Proxmox

apt update
apt upgrade -y
apt install curl -y
curl -o script_install.sh https://raw.githubusercontent.com/TaoMelais/ansible-luma/refs/heads/main/script_install.sh
. script_install.sh




# Fonctionnement

Récupération de script_install.sh depuis github via curl.
Il execute le script_install.sh.

Le script_install.sh va :
    - installer des dépendances
    - configurer la locale
    - cloner le repo ansible
    - creer un .env
    - execute install_grafana.yml avec ansible



---- OLD -----


## Prérequis

1. Container Proxmox créé et accessible via SSH
2. Ansible installé sur votre machine locale
3. Accès root ou sudo sur le container

## Configuration

### 1. Modifier l'inventaire

Éditez `inventory.ini` et remplacez :
- `192.168.1.100` par l'IP de votre container Proxmox
- `ansible_user` si vous n'utilisez pas root
- Le chemin de la clé SSH si nécessaire

### 2. Personnaliser les variables

Éditez `vars.yml` pour configurer :
- Le mot de passe admin Grafana
- Le port d'écoute
- Les variables d'environnement

## Utilisation

### Installation simple

```bash
ansible-playbook install_grafana.yml
```

### Avec les variables personnalisées

```bash
ansible-playbook install_grafana.yml -e @vars.yml
```

### Test de connexion

```bash
ansible grafana_container -m ping
```

### Vérifier l'installation

```bash
ansible grafana_container -m shell -a "systemctl status grafana-server"
```

## Accès à Grafana

Après l'installation, accédez à Grafana via :
- URL : `http://IP_CONTAINER:3000`
- Utilisateur : `admin`
- Mot de passe : celui défini dans `vars.yml`

## Dépannage

### Vérifier les logs

```bash
ansible grafana_container -m shell -a "journalctl -u grafana-server -n 50"
```

### Redémarrer Grafana

```bash
ansible grafana_container -m systemd -a "name=grafana-server state=restarted" --become
```
