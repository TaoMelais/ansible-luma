# Installation des dépendances
apt install -y sudo wget gnupg lsb-release git locales python3 python3-pip python3-venv ansible

# Configuration de la locale
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure -f noninteractive locales
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Cloner le repository Ansible
cd ~
git clone https://github.com/TaoMelais/ansible-luma.git
cd ansible-luma/

# Créer et activer l'environnement virtuel Python
python3 -m venv ~/ansible-venv
source ~/ansible-venv/bin/activate

# Installer les dépendances Python
pip install --upgrade pip
pip install netaddr ansible

# Exécuter le playbook Ansible
ansible-playbook install_grafana.yml