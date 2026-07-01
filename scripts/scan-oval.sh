#!/bin/bash
# =============================================================
# SEC-OPS LAB - Script de scan de conformite OVAL Canonical
# Auteur : ABDALLI Fatima - ENSIASD
#
# Ce script telecharge le fichier OVAL officiel Canonical
# correspondant a la version Ubuntu de la machine, puis lance
# un audit de conformite via OpenSCAP (oscap).
# =============================================================


# Verification qu'oscap est installe
if ! command -v oscap &> /dev/null; then
    echo "[ERREUR] OpenSCAP (oscap) n'est pas installe."
    echo "Installer avec : sudo apt install -y libopenscap8 ssg-debderived"
    exit 1
fi

echo "[1/4] Telechargement du fichier OVAL officiel Canonical..."
wget -q "https://security-metadata.canonical.com/oval/${OVAL_BZ2}" -O "${OVAL_BZ2}"

echo "[2/4] Decompression du fichier OVAL..."
bzip2 -f -d "${OVAL_BZ2}"

echo "[3/4] Lancement du scan OVAL (cela peut prendre quelques minutes)..."
sudo oscap oval eval \
    --report "${HOME}/${REPORT_NAME}" \
    "${OVAL_XML}"

echo "[4/4] Scan termine."
echo "Rapport genere : ${HOME}/${REPORT_NAME}"
echo "=========================================================="
