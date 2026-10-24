#!/usr/bin/env bash
# Ejecutar dentro de la carpeta viasbolivia-peaje (con README.md y database/ ya presentes)
set -e
git init -b main
git config user.name "Moises Rodriguez Mamani"
git config user.email "tu-correo@ejemplo.com"   # cambia por tu correo
git add README.md
git commit -m "chore: commit inicial con README del proyecto"
git branch develop
git switch develop
git switch -c feature/modelo-relacional
git add database/01_schema.sql
git commit -m "feat(db): crea tablas rol, usuario, carril, categoria_vehicular, tarifa, paso_vehicular y bitacora"
git add database/02_datos_prueba.sql database/03_consultas.sql
git commit -m "feat(db): agrega datos de prueba y consultas SELECT de recaudación y revisión de lecturas"
git switch develop
git merge --no-ff feature/modelo-relacional -m "merge: integra feature/modelo-relacional en develop"
git branch -a
git log --oneline --graph --all
# Luego: git remote add origin https://github.com/TU-USUARIO/viasbolivia-peaje.git
#        git push -u origin main develop feature/modelo-relacional
