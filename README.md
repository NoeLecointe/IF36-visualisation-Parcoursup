# Projet IF36: groupe "Invisible Touch" P23

# INTRODUCTION

## Membres 
• Noé LECOINTE 
• Esso-Manam MANGANMANA
• Matheo BEGIS
• Xinyuan ZHAI

---

## Données
Nous choisisons le dataset **"Parcoursup 2022 - vœux de poursuite d'études et de réorientation dans l'enseignement supérieur et réponses des établissements"**, disponible via le lien https://data.education.gouv.fr/explore/dataset/fr-esr-parcoursup/table/?sort=tri
Nous avons également à notre disposition la méthodologie permettant d'interpréter ce jeu de données, qui est téléchargeable depuis ce lien: https://data.education.gouv.fr/api/datasets/1.0/fr-esr-parcoursup/attachments/methodologie_opendata_2022_pdf/
Ce fichier nous permet surtout d'interpréter les noms de variables.

Ce jeu de données, de source gouvernementale, présente les voeux de poursuite d'études et de réorientation ainsi que les propositions des établissements. Les données sont collectées à partir de la plateforme Parcoursup, couvrant l'ensemble de la campagne 2022 jusqu'au 16 septembre 2022. Nous avons choisi ce jeu de données car ayant déjà utilisé la plateforme ParcourSup et fait des recherches par rapport à nos propres orientations, nous sommes intéréressé par ce jeu de données et serons en mesure de nous poser des questions intéressantes.

• Il concerne **13644** observations différentes, chacune représentant une formation proposée dans un établissement(hors apprentissage). Par exemple: Formation d'ingénieur Bac + 5 - bac STI2D,STL à l'INSA Toulouse
En plus, ce jeu de données couvre **967664** candidats différents, ais il existe un sous ensemble de données, qui porte sur les **624620** néo-bacheliers parmi les candidats.

• Il concerne **118** variables différentes telles que "cod_uai": identifiant de l'établissement; "dep": code départemental de l'établissement; "Fili": filière de formation très agrégée.. Les formats des variables varient également, par exemple:
  - chaînes de caractères: "g_ea_lib_vx" - INSA Toulouse
  - entiers: "dep" - 31
  - float: "acc_debutpp" - 14.0
  - Couple de float: "g_olocalisation_des_formations" - 43.5704,1.46794


---



## Plan d'analyse
