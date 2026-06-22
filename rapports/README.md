# Rapports d'Audit OVAL

Ce dossier contient les rapports d'audit OpenSCAP générés lors du projet.

## Contenu

- `initial/` — Rapport OVAL avant hardening (Score : 146/149 — 97.9%)
- `final/` — Rapport OVAL après hardening (Score : 148/149 — 99.3%)

## Comment générer un rapport

Depuis Ubuntu1 (machine cible) :

```bash
bash ~/sec-ops-lab/scripts/scan-oval.sh
```

## Interprétation des résultats

| Couleur | Signification |
|---|---|
| 🟢 Vert | Package patché — pas de vulnérabilité |
| 🔴 Rouge | Package vulnérable — CVE non corrigée |

## Note

Les fichiers HTML et XML de rapport ne sont pas versionnés dans Git (trop volumineux).
Ils sont générés localement en exécutant le script de scan.
