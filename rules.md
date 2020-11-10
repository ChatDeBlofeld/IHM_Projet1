## Règles d'écriture de dates

### Valeurs par défaut
- Heure : 09h 
- Minute : 00
- Année : Année courante si la date est à venir dans l'année, ou la suivante

A noter que si une deadline passée est entrée, elle indiquera une alerte immédiatement.
Si le champ est laissé vide ou contient une valeur invalide, aucune deadline n'est fixée.

### Heure
`<heure> ( ':' ou 'h') [minute]`
Écrire une heure entre 0 et 23, éventuellement suivie d'un nombre de minutes. La deadline sera fixée à la prochaine occurence de l'horaire indiqué.

### Jour de la semaine
`<jour> [heure ( ':' ou 'h') minute]`
Écrire un jour de la semaine (lundi, mardi, ...). La deadline sera fixée au jour de la semaine donné à venir (donc si on est mercredi et qu'on écrit lundi, elle sera fixée le lundi suivant). Une heure peut être précisée.
"Demain" est une valeur acceptable pour `<jour>`.

### Date
`<jour>(. ou /)<mois>[(. ou /)année] [<heure> ( ':' ou 'h') [minute]]`
Écrire une date avec au moins un jour et un mois. Une année et/ou une heure peuvent être ajoutées. La deadline sera fixée à la prochaine occurence de la date indiquée. Les jours et les mois sont uniquement acceptés en format numérique pour cette syntaxe.

### Date longue
`[le ]<jour> <mois>[ année]  [[à] <heure> ( ':' ou 'h') [minute]]`
Écrire une date en format littéraire (p. ex "le 26 décembre 2021 à 16h"). Une année et/ou une heure peuvent être ajoutées. Il est possible de préfixer la date par "le", et l'heure par "à". La casse n'est pas prise en compte pour le nom du mois. La deadline sera fixée à la prochaine occurence de la date indiquée.