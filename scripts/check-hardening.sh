#!/bin/bash
# =============================================================
# SEC-OPS LAB - Script de verification post-hardening
# Auteur : ABDALLI Fatima - ENSIASD
#
# Verifie manuellement que les regles CIS appliquees par le
# playbook Ansible hardening.yml sont bien actives sur la
# machine cible (Ubuntu1).
#
# Usage : ./check-hardening.sh
# =============================================================

echo "=========================================================="
echo " SEC-OPS LAB - Verification post-hardening"
echo "=========================================================="

echo ""
echo "--- [CIS 5.2.x] Configuration SSH ---"
grep -E "PermitRootLogin|MaxAuthTries|ClientAliveInterval|X11Forwarding" /etc/ssh/sshd_config

echo ""
echo "--- [CIS 3.5.x] Pare-feu UFW ---"
sudo ufw status verbose

echo ""
echo "--- [CIS 5.4.1] Politique de mots de passe ---"
cat /etc/security/pwquality.conf | grep -v "^#" | grep -v "^$"

echo ""
echo "--- [CIS 4.1.1] Service auditd ---"
sudo systemctl status auditd --no-pager | head -n 5

echo ""
echo "--- [CIS 3.x] Parametres reseau kernel ---"
sysctl net.ipv4.ip_forward
sysctl net.ipv4.conf.all.accept_redirects
sysctl net.ipv4.conf.all.accept_source_route

echo ""
echo "=========================================================="
echo " Verification terminee."
echo "=========================================================="
