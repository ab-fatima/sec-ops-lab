# Documentation du Projet SEC-OPS LAB

Ce répertoire contient l'ensemble de la documentation technique et des livrables du projet **SEC-OPS LAB**. Ces documents décrivent en détail l'architecture, les procédures de durcissement et les résultats des audits de sécurité réalisés dans le cadre du stage au CHU Mohammed VI de Marrakech.

## 📁 Contenu du Dossier

| Fichier | Description |
| :--- | :--- |
| `DAT-SEC-OPS-LAB.pdf` | **Dossier d'Architecture Technique** : Document cadre présentant le contexte, les objectifs, l'architecture du laboratoire virtuel, les outils utilisés (Ansible, OpenSCAP, Wazuh) ainsi que le planning et les livrables du projet. |
| `guide_hardening.pdf` | **Guide Technique de Hardening** : Document opérationnel détaillant l'ensemble des règles de durcissement appliquées (basées sur le CIS Benchmark). Il contient les commandes Ansible, les configurations modifiées et les impacts de chaque mesure. |
| `rapport_de_conformite.pdf` | **Rapport d'Audit de Conformité** : Analyse comparative des audits de sécurité (initial et final) réalisés avec OpenSCAP. Ce rapport quantifie l'amélioration du score de sécurité, passant de 97.9% à 99.3%, et détaille l'élimination des vulnérabilités CVE. |

---

## 📖 Résumé des Documents

### 1. Dossier d'Architecture Technique (`DAT-SEC-OPS-LAB.pdf`)

Ce document pose les fondations du projet. Il précise le contexte de la sécurité dans un environnement hospitalier et définit les objectifs (automatisation du hardening, audit de conformité, supervision continue). Il détaille également :
- **L'architecture du laboratoire** : 3 machines virtuelles (Ubuntu Controller, Ubuntu Cible, Kali Linux) sur un réseau interne isolé (`192.168.10.0/24`).
- **Les technologies clés** : Ansible (automatisation), OpenSCAP (audit), Wazuh (supervision SIEM).
- **Le planning** : Une organisation en 4 semaines (juin-juillet 2026) avec des jalons de validation clairs.
- **Les livrables** : Architecture technique, code Ansible, guide de hardening, rapports OpenSCAP.

### 2. Guide Technique de Hardening (`guide_hardening.pdf`)

Un guide pratique destiné aux administrateurs systèmes. Il décrit pas à pas l'exécution du playbook Ansible et détaille les 9 règles CIS implémentées, réparties en 5 blocs fonctionnels :
1.  **Durcissement SSH** (Ex: interdiction du login root, limitation des tentatives).
2.  **Pare-feu UFW** (Activation et politique de refus par défaut).
3.  **Politique des mots de passe** (Complexité et longueur minimale).
4.  **Journalisation** (Activation du service `auditd`).
5.  **Paramètres réseau du noyau** (Désactivation du `IP forwarding`).

Chaque règle est accompagnée de sa référence CIS, de son impact sur la sécurité, et du code Ansible correspondant.

### 3. Rapport d'Audit de Conformité (`rapport_de_conformite.pdf`)

Ce rapport présente les preuves chiffrées de l'efficacité du projet. Il compare les résultats des audits OpenSCAP avant et après l'application du hardening.
- **Audit Initial** : Score de **97.9%** avec 2 vulnérabilités CVE critiques identifiées.
- **Audit Final** : Score de **99.3%** avec **0 vulnérabilité CVE** résiduelle.
- **Conclusion** : L'objectif de dépasser les 80% de conformité est largement atteint. Les 2 CVE ont été corrigées via `apt upgrade`, et les 9 règles CIS ont été appliquées avec succès (résultat Ansible : `ok=12, changed=7, failed=0`).

---

## 🏗️ Contexte du Projet

Ce projet a été réalisé par **Fatima ABDALLI**, étudiante en Sécurité IT et Confiance Numérique à l'ENSIASD Taroudant, dans le cadre d'un stage de 4 semaines au **CHU Mohammed VI de Marrakech**.

L'objectif était de concevoir une plateforme d'automatisation du durcissement des serveurs Linux, en utilisant des standards internationaux (CIS Benchmarks), dans un environnement virtuel .

---
**Auteur :** Fatima ABDALLI
**Période :** 8 Juin – 8 Juillet 2026
**Version :** 1.0