# Rapports d'Audit OpenSCAP

Ce répertoire contient les rapports d'audit de conformité générés par **OpenSCAP** dans le cadre du projet SEC-OPS LAB. Ils permettent de mesurer objectivement l'impact du hardening appliqué sur le système Ubuntu 26.04 LTS.

## 📁 Contenu du Dossier

| Fichier | Description |
| :--- | :--- |
| `rapport-initial.html` | Rapport d'audit initial avant toute intervention de durcissement. |
| `rapport-final.html` | Rapport d'audit final après l'application du hardening via Ansible. |

---

## 📊 Synthèse des Résultats

L'audit a été réalisé à l'aide du fichier OVAL officiel de Canonical, qui évalue les vulnérabilités connues (CVE) et les mises à jour de sécurité manquantes.

| Métrique | Audit Initial | Audit Final |
| :--- | :--- | :--- |
| **Définitions OVAL** | 149 Total | 149 Total |
| **✅ Packages à jour (sécurisés)** | **146 / 149** | **148 / 149** |
| **❌ Vulnérabilités CVE détectées** | **2** | **0** |
| **Score de conformité** | **97.9%** | **99.3%** |

### Visualisation des Résultats

- **Audit Initial** : 2 CVE non corrigées (libheif, Vim).
- **Audit Final** : **0 CVE résiduelle** — toutes les vulnérabilités ont été éliminées après mise à jour des packages et durcissement.

---

## 📝 Note sur la Méthodologie

⚠️ **Version Ubuntu** : Ubuntu 26.04 (Resolute) est une version récente. Les profils CIS XCCDF standards ne la reconnaissent pas, provoquant un score de 0% avec la méthode classique.  
✔️ **Solution adoptée** : Utilisation du **fichier OVAL officiel fourni par Canonical**, qui est le référentiel de vulnérabilités spécifique à chaque version d'Ubuntu. Cette méthode est officiellement recommandée par Canonical.

---

## 🔗 Références

- [OpenSCAP](https://www.open-scap.org/)
- [Canonical OVAL Repository](https://security-metadata.canonical.com/oval/)

---
**Audit réalisé par :** Fatima ABDALLI  
**Date :** 22 Juin 2026