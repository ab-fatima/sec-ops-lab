# SEC-OPS LAB

Automatisation du Hardening et Supervision de la Sécurité des Infrastructures IT

**Projet de stage d'ingénieur — CHU Mohammed VI, Marrakech**
**Réalisé par :** ABDALLI Fatima
**École :** ENSIASD Taroudant — Sécurité IT et Confiance Numérique
**Encadrant CHU :** M. Abdelmoula Boucham
**Encadrant ENSIASD :** M. Mohamed Saad Azizi
**Période :** 8 juin – 8 juillet 2025

---

## 📋 Description

SEC-OPS LAB est une plateforme virtualisée de durcissement (hardening) et de
supervision de la sécurité des infrastructures Linux, développée dans le cadre
d'un stage au CHU Mohammed VI de Marrakech. Le projet combine trois outils
open source complémentaires :

| Outil | Rôle |
|---|---|
| **Ansible** | Automatisation du hardening (CIS Benchmark) |
| **OpenSCAP** | Audit de conformité (avant / après) |
| **Wazuh** | SIEM — supervision continue des dérives de configuration |

## 🏗️ Architecture

Le lab est composé de 3 machines virtuelles interconnectées via un réseau
interne isolé VirtualBox (`labnet`, `192.168.10.0/24`) :

| VM | IP | Rôle |
|---|---|---|
| Ubuntu2 | 192.168.10.20 | Controller Ansible / Manager Wazuh / Scanner OpenSCAP |
| Ubuntu1 | 192.168.10.10 | Machine cible — à auditer et durcir |
| Kali Linux | 192.168.10.30 | Tests de dérive et simulation |

> ⚠️ Environnement 100% isolé, sans connexion au réseau de production du CHU.

## 📂 Structure du dépôt

```
sec-ops-lab/
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbooks/
│   │   └── hardening.yml
│   └── roles/
│       └── linux_hardening/
│           ├── tasks/main.yml
│           └── handlers/main.yml
├── documentation/          # DAT, Hardening Guide (PDF)
├── rapports/
│   ├── initial/            # Rapport OpenSCAP avant hardening
│   └── final/              # Rapport OpenSCAP après hardening
├── scripts/
│   ├── scan-oval.sh        # Scan de conformité OVAL Canonical
│   └── check-hardening.sh  # Vérification manuelle post-hardening
├── .gitignore
└── README.md
```

## ⚙️ Prérequis

- Ansible Core ≥ 2.14 (machine Controller)
- Collections Ansible : `community.general`, `ansible.posix`
- OpenSCAP (`libopenscap8`, `ssg-debderived`)
- Accès SSH par clé entre le Controller et la machine cible

```bash
ansible-galaxy collection install community.general ansible.posix
```

## 🚀 Utilisation

### 1. Vérifier la connectivité Ansible

```bash
cd ansible
ansible all -i inventory/hosts.ini -m ping
```

### 2. Test à blanc (dry-run)

```bash
ansible-playbook -i inventory/hosts.ini playbooks/hardening.yml --check
```

### 3. Appliquer le hardening

```bash
ansible-playbook -i inventory/hosts.ini playbooks/hardening.yml
```

### 4. Auditer la conformité (avant / après)

```bash
cd scripts
chmod +x scan-oval.sh
./scan-oval.sh rapport-initial.html   # avant hardening
./scan-oval.sh rapport-final.html     # après hardening
```

### 5. Vérifier manuellement le hardening appliqué

```bash
chmod +x check-hardening.sh
./check-hardening.sh
```

## 🔐 Règles CIS appliquées

Le playbook `hardening.yml` applique les mesures suivantes, basées sur le
**CIS Ubuntu Benchmark Level 1 Server** :

| Réf. CIS | Règle |
|---|---|
| 5.2.4 | Interdire le login root en SSH |
| 5.2.13 | Limiter les tentatives d'authentification SSH à 3 |
| 5.2.11 | Timeout de session SSH (300s) |
| 5.2.6 | Désactiver X11 Forwarding |
| 3.5.1.1 / 3.5.1.4 | Activer UFW avec politique deny-all entrant |
| 5.4.1 | Politique de mots de passe (minlen=14, minclass=3) |
| 4.1.1 | Activer la journalisation auditd |
| 3.1.1 | Désactiver l'IP Forwarding |
| 3.2.2 | Désactiver les ICMP Redirects |
| 3.3.1 | Désactiver le Source Routing |

## 📊 Résultats

- **Score de conformité OVAL** : 97.9% → **99.3%**
- **Vulnérabilités CVE** : 2 → **0**
- **Règles CIS appliquées** : 9 (via Ansible, `failed=0`)

## 🔒 Sécurité et confidentialité

- Lab entièrement isolé du réseau de production du CHU
- Aucune donnée patient réelle utilisée
- Mots de passe des fichiers de configuration fictifs, à usage du lab uniquement

## 📄 Licence

Ce projet et sa documentation sont la propriété exclusive du CHU Mohammed VI
de Marrakech, réalisés dans le cadre du stage d'ingénieur d'ABDALLI Fatima
(ENSIASD Taroudant).
