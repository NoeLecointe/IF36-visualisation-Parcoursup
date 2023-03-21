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
Le dataset de Parcoursup pour l'année 2022 permet d'obtenir une multitude de données sur les taux de candidatures, notamment les chiffres pour chaque formation, pour chaque académie et pour chaque type de baccalauréat. Nous allons donc étudier sous quatre axes le dataset.

Dans un premier temps nous allons **étudier les établissements** sur lesquels le dataset se base. On pourra notamment répondre aux questions suivantes :
- Quels sont les types de formations les plus représentés ?
- Pouvons-nous observer un regroupement des formations de manière géographique ?
- Certaines régions de France ont-elles plus de capacités à accueillir que d’autres ?
- Parcourpsup a-t-il plus de formation professionnel ou générale ?
- **tobedone**

Dans un second temps nous allons chercher à étudier les **taux de candidatures des étudiants**. Nous allons par exemple pourvoir répondre aux questions suivantes :
- Quel est le nombre de candidatures par filière en 2022 ?
- Quel est le nombre de candidatures par académie en 2022 ?
- Quel est le nombre de candidature d’étudier boursier/non-boursier par formation ?
- **tobedone**

Le dataset de Parcoursup pour l'année 2022 permet également d'obtenir des données sur les taux d'acceptations, c'est-à-dire le pourcentage de candidats qui ont été acceptés dans une filière donnée. Voici les questions que l'on peut se poser en utilisant ce dataset :
- Quel est le taux d'acceptation global pour toutes les filières ?
- Quels sont les taux d'acceptation par académie ?
- Quels sont les taux d'acceptation par type de baccalauréat en 2022 ?
- Quel est le nombre de réponse satisfaisante pour un candidat boursier/non-boursier par formation ? Le statut de l’étudiant joue-t-il dans la réponse ?
- **tobedone**

Enfin nous pourrons étudier un établissement en particulier pour étudier certaines données. On prendra par exemple l’Université de Technologie de Troyes qu’on pourra comparer aux autres écoles du même groupe. Voici quelques exemple de questions :
- **tobedone**

