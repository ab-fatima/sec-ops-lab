#!/bin/bash
# =============================================================
#  SEC-OPS LAB — Script d'audit OVAL automatisé
#  Auteur : ABDALLI Fatima — ENSIASD / CHU Mohammed VI
# =============================================================

set -e

DATE=$(date +%Y%m%d-%H%M)
OVAL_FILE="$HOME/com.ubuntu.resolute.usn.oval.xml"
OVAL_URL="https://security-metadata.canonical.com/oval/com.ubuntu.$(lsb_release -cs).usn.oval.xml.bz2"
REPORT_DIR="$HOME/sec-ops-lab/rapports"

echo "=========================================="
echo "  SEC-OPS LAB — Audit OVAL Ubuntu $(lsb_release -rs)"
echo "  Date : $(date)"
echo "=========================================="

# Télécharger le fichier OVAL si nécessaire
if [ ! -f "$OVAL_FILE" ]; then
    echo "[*] Téléchargement du fichier OVAL Canonical..."
    wget -q "$OVAL_URL" -O "/tmp/oval.xml.bz2"
    bzip2 -d /tmp/oval.xml.bz2
    mv /tmp/oval.xml "$OVAL_FILE"
    echo "[+] Fichier OVAL téléchargé."
else
    echo "[*] Fichier OVAL existant trouvé."
fi

# Lancer le scan
echo "[*] Lancement du scan OVAL..."
sudo oscap oval eval \
    --results "$REPORT_DIR/scan-$DATE.xml" \
    --report "$REPORT_DIR/rapport-$DATE.html" \
    "$OVAL_FILE"

echo ""
echo "[+] Scan terminé !"
echo "[+] Rapport HTML : $REPORT_DIR/rapport-$DATE.html"
echo "[+] Résultats XML : $REPORT_DIR/scan-$DATE.xml"
echo ""
echo "Score :"
grep -o "true\|false" "$REPORT_DIR/rapport-$DATE.html" | sort | uniq -c
