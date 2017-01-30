# MEDIT

[Medite] Appli iOS Swift 3 réalisée dans le cadre du Master CIM
>>  Anaïs V. - WTFPLicense - *.Omega3 Version.* Release

## Les fonctionnalités

* Séance méditative   
Installez vous confortablement dans un endroit calme et si possible sans trop de luminosité. Choisissez le nombre de minutes pour votre séance et appuyez sur le bouton *Démarrer*, c’est Parti ! Fermez les yeux, respirez, recentrez vous sur vous-même, détendez vous ! Un gong vous avertira de la fin de la séance.

* Journal de bord   
Écrivez vos impressions après la séance (ou en dehors de la séance). Appuyez longtemps sur le titre de votre contenu dans la liste pour le supprimer. Dans cette version, il n’est malheureusement **pas possible** de modifier le contenu enregistré.

* Son   
Faites bouger votre appareil OS X pour lancer le son Carillon!


## Composants utilisés - pour les développeurs
* Timer
* AVFoundation : lecture audio et synthétiseur vocal
* CoreMotion : usage de l'accelerometre
* Contrôle de la luminosité de l'appareil (UIScreen.main.brightness)
* Gestuelle LongPress (UILongPressGestureRecognizer)
* UITableView : population des cellules
* fileManager : Enregistrement, lecture, suppression de fichiers txt 


## Améliorations à faire
* Amélioration de la gestion des view
* Amélioration de la gestion du journal de bord
* Pourquoi pas remplacer le Gong par une vibration? Pas trop forte cependant pour ne pas sortir de sa séance en étant plus stressé qu’avant :-)
* Pourquoi ne pas lancer un nouveau son détente en soufflant sur le microphone ?
* Gérer/Maîtriser  sa respiration en soufflant sur le microphone
* etc.




