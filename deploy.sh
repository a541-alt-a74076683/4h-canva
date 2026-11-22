#!/data/data/com.termux/files/usr/bin/bash
set -e
cd ~/4h-canva

[ -d ~/storage ] || termux-setup-storage

git add -A
git commit -m "update $(date +%H:%M)" -q || echo "nada pra commitar"
git push

RUN_ID=$(gh run list --limit 1 --json databaseId -q '.[0].databaseId')
echo "Acompanhando run $RUN_ID..."
gh run watch "$RUN_ID" --exit-status

gh run download "$RUN_ID" -n paper-apk -D ~/storage/downloads
echo "✅ APK salvo na pasta Download"
