# Installation des dépendances
apt install -y sudo wget gnupg lsb-release git locales python3 python3-pip python3-venv ansible unzip

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
ansible-playbook 03-install_loki.yml

# Vérifications après installation
echo "=== Vérification de Loki ==="
sleep 5
systemctl status loki || echo "⚠️ Loki not running"

echo ""
echo "=== Vérification du port 3100 ==="
ss -tlnp | grep 3100 || echo "⚠️ Port 3100 not listening"
echo ""
echo "=== Derniers logs Grafana ==="
journalctl -u grafana-server -n 20 --no-pager


ansible-playbook 04-install_promtail.yml

echo "=== Vérification de Promtail ==="
sleep 5
systemctl status promtail || echo "⚠️ Promtail not running"
echo ""
echo "=== Vérification du port 9080 ==="
ss -tlnp | grep 9080 || echo "⚠️ Port 908
0 not listening"
echo ""
echo "=== Derniers logs Promtail ==="
journalctl -u promtail -n 20 --no-pager
deactivate
echo "Installation de Loki et Promtail terminée."