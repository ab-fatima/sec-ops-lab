# SEC-OPS LAB — Plateforme d'Automatisation du Hardening IT

[![Ansible](https://img.shields.io/badge/Ansible-2.14+-red?style=flat-square&logo=ansible)](https://www.ansible.com/)
[![OpenSCAP](https://img.shields.io/badge/OpenSCAP-1.4.3-blue?style=flat-square)](https://www.open-scap.org/)
[![Wazuh](https://img.shields.io/badge/Wazuh-4.7-green?style=flat-square)](https://wazuh.com/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-26.04_LTS-orange?style=flat-square&logo=ubuntu)](https://ubuntu.com/)

## Présentation

Projet de stage réalisé au **Centre Hospitalier Universitaire Mohammed VI de Marrakech** dans le cadre de la première année du cycle ingénieur en **Sécurité IT et Confiance Numérique** à **ENSIASD Taroudant**.

**Objectif :** Concevoir un laboratoire virtuel isolé permettant d'automatiser le durcissement (hardening) des infrastructures IT hospitalières, d'auditer leur conformité et de superviser les dérives de configuration en temps réel.

---

## Architecture du Lab

```
┌─────────────────────────────────────────────────────┐
│           RÉSEAU INTERNE ISOLÉ : labnet              │
│                 192.168.10.0/24                      │
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │   Ubuntu2    │  │   Ubuntu1    │  │    Kali    │ │
│  │  Controller  │  │    Cible     │  │   Tests    │ │
│  │192.168.10.20 │  │192.168.10.10 │  │192.168.10.30│ │
│  │              │  │              │  │            │ │
│  │ Ansible      │──│ Machine à    │  │ Tests de   │ │
│  │ OpenSCAP     │  │ durcir       │  │ dérive     │ │
│  │ Wazuh Mgr    │  │ Wazuh Agent  │  │            │ │
│  └──────────────┘  └──────────────┘  └────────────┘ │
└─────────────────────────────────────────────────────┘
```

| VM | OS | IP | User | Rôle |
|---|---|---|---|---|
| Ubuntu2 | Ubuntu 26.04 LTS | 192.168.10.20 | ubunto | Controller |
| Ubuntu1 | Ubuntu 26.04 LTS | 192.168.10.10 | ubunto | Cible |
| Kali | Kali Linux | 192.168.10.30 | kali | Tests |

---

## Outils utilisés

| Outil | Version | Rôle |
|---|---|---|
| Ansible | 2.14+ | Automatisation du hardening (IaC) |
| OpenSCAP | 1.4.3 | Audit de conformité OVAL |
| Wazuh | 4.7 | SIEM — Supervision et détection de dérives |
| VirtualBox | 7.x | Hyperviseur — environnement isolé |

---

## Structure du projet

```
sec-ops-lab/
├── ansible/
│   ├── ansible.cfg              # Configuration Ansible
│   ├── inventory/
│   │   └── hosts.ini            # Inventaire des machines
│   └── playbooks/
│       └── hardening.yml        # Playbook de hardening CIS
├── rapports/
│   ├── initial/                 # Rapport OVAL avant hardening
│   └── final/                   # Rapport OVAL après hardening
├── documentation/
│   └── DAT-SEC-OPS-LAB.tex      # Dossier d'Architecture Technique
├── scripts/
│   └── scan-oval.sh             # Script d'audit OVAL automatisé
└── README.md
```

---

## Résultats obtenus

### Hardening Ansible
| Règle CIS | Mesure | Résultat |
|---|---|---|
| CIS 5.2.4 | Interdire root SSH | ✅ Appliqué |
| CIS 5.2.13 | Max tentatives SSH = 3 | ✅ Appliqué |
| CIS 5.2.11 | Timeout SSH = 300s | ✅ Appliqué |
| CIS 3.5.1.4 | Activer UFW | ✅ Appliqué |
| CIS 5.4.1 | Mot de passe min 14 chars | ✅ Appliqué |
| CIS 4.1.1 | Activer auditd | ✅ Appliqué |
| CIS 3.1.1 | Désactiver IP Forwarding | ✅ Appliqué |

### Audit OVAL
| Métrique | Avant | Après |
|---|---|---|
| CVE détectées | 2 | 0 |
| Packages patchés | 146/149 | 148/149 |
| Score | 97.9% | **99.3%** |

---

## Utilisation

### Prérequis
- VirtualBox installé
- 3 VMs Ubuntu 26.04 + Kali configurées sur le réseau `labnet`
- SSH sans mot de passe configuré entre Ubuntu2 → Ubuntu1 et Kali

### Lancer le hardening

```bash
# Depuis Ubuntu2 (Controller)
cd ~/sec-ops-lab/ansible

# Test à blanc (dry-run)
ansible-playbook -i inventory/hosts.ini playbooks/hardening.yml --check

# Appliquer le hardening
ansible-playbook -i inventory/hosts.ini playbooks/hardening.yml
```

### Lancer l'audit OVAL

```bash
# Depuis Ubuntu1 (Cible)
bash ~/sec-ops-lab/scripts/scan-oval.sh
```

---

## Note technique — Compatibilité OpenSCAP

Ubuntu 26.04 (Resolute) n'est pas encore supporté par les profils CIS XCCDF existants (incompatibilité CPE — toutes les règles retournent `notapplicable`). La méthode OVAL officielle Canonical a été adoptée comme solution :

```bash
wget https://security-metadata.canonical.com/oval/com.ubuntu.resolute.usn.oval.xml.bz2
bzip2 -d com.ubuntu.resolute.usn.oval.xml.bz2
sudo oscap oval eval --report rapport.html com.ubuntu.resolute.usn.oval.xml
```

---

## Informations du projet

| Champ | Valeur |
|---|---|
| Stagiaire | ABDALLI Fatima |
| École | ENSIASD Taroudant |
| Spécialité | Sécurité IT et Confiance Numérique |
| Organisme | CHU Mohammed VI — Marrakech |
| Encadrant CHU | M. Abdelmoula Boucham |
| Encadrant ENSIASD | M. Mohamed Saad Azizi |
| Période | 8 juin – 8 juillet 2025 |

---

*Projet réalisé dans un environnement 100% virtualisé et isolé — aucune connexion au réseau de production du CHU.*
