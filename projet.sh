#!/bin/bash

# Fonction pour navigation dans les répertoires
naviguer() {
 local current_dir=$(pwd)  
    echo "Entrer le nom d'un répertoire pour y accéder (.. pour remonter, q pour quitter) "
    read choix
    if [ "$choix" == ".." ]; then
        cd ..
    elif [ "$choix" == "q" ]; then
        exit 0
    else
        if [ -d "$choix" ]; then
            cd "$choix" || { cd "$current_dir"; return; }  
        else
            echo "Répertoire non trouvé" 
        fi
    fi
   
}

# Fonction pour créer des fichiers
creer_f() {
    echo "Saisir le nom du fichier à créer"
    read nom_fichier
    if touch "$nom_fichier"; then
        echo "Le fichier $nom_fichier est créé"
    else
        echo "Erreur : Impossible de créer le fichier"
    fi
}

# Fonction pour supprimer des fichiers
supprimer_f() {
    echo "Saisir le nom du fichier à supprimer"
    read nom_fichier  
    if rm -i "$nom_fichier"; then
        echo "Le fichier $nom_fichier est supprimé"
    else
        echo "Erreur : Impossible de supprimer le fichier"
    fi
}

# Fonction pour renommer des fichiers
renommer_f() {
    echo "Saisir le nom du fichier à renommer"
    read ancien_nom  
    echo "Saisir le nouveau nom"
    read nouveau_nom
    if mv "$ancien_nom" "$nouveau_nom"; then
        echo "Le fichier est renommé"
    else
        echo "Erreur : Impossible de renommer le fichier"
    fi
}

# Fonction pour créer des répertoires
creer_R() {
    echo "Saisir le nom du répertoire à créer"
    read nom_repertoire
    if mkdir "$nom_repertoire"; then
        echo "Le répertoire $nom_repertoire est créé"
    else
        echo "Erreur : Impossible de créer le répertoire"
    fi
}

# Fonction pour supprimer des répertoires
supprimer_R() {
    echo "Saisir le nom du répertoire à supprimer"
    read nom_repertoire  
    if rm -ir "$nom_repertoire"; then
        echo "Le répertoire $nom_repertoire est supprimé"
    else
        echo "Erreur : Impossible de supprimer le répertoire"
    fi
}

# Fonction pour renommer des répertoires
renommer_R() {
    echo "Saisir le nom du répertoire à renommer"
    read ancien_nom  
    echo "Saisir le nouveau nom"
    read nouveau_nom
    if mv "$ancien_nom" "$nouveau_nom"; then
        echo "Le répertoire est renommé"
    else
        echo "Erreur : Impossible de renommer le répertoire"
    fi
}

# Fonction pour copier des fichiers
copier_f() {
    echo "Saisir le nom du fichier à copier"
    read nom_fichier  
    echo "Saisir le nom de destination"
    read destination
    if cp "$nom_fichier" "$destination"; then
        echo "Le fichier est copié"
    else
        echo "Erreur : Impossible de copier le fichier"
    fi
}

# Fonction pour déplacer des fichiers
deplacer_f() {
    echo "Saisir le nom du fichier à déplacer"
    read nom_fichier  
    echo "Saisir le nom de destination"
    read destination
    if mv "$nom_fichier" "$destination"; then
        echo "Le fichier est déplacé"
    else
        echo "Erreur : Impossible de déplacer le fichier"
    fi
}

# Fonction pour rechercher des fichiers
rechercher_f() {
    echo "Saisir le nom du fichier à rechercher"
    read nom_fichier  
    result=$(find . -type f -name "$nom_fichier")
    if [ -n "$result" ]; then
        echo "$result"
        echo "Recherche terminée"
    else
        echo "Aucun fichier trouvé"
    fi
}

# Fonction pour gérer les autorisations
gestion_autorisation() {
    echo "Saisir le nom du fichier ou répertoire"
    read nom_fichier  
    echo "Saisir les autorisations (ex: u+rwx...)"
    read autorisations
    if chmod "$autorisations" "$nom_fichier"; then
        echo "Les autorisations sont mises à jour"
    else
        echo "Erreur : Impossible de mettre à jour les autorisations"
    fi
}

# Fonction pour modifier les timestamps
modifier_timestamps() {
    echo "Saisir le nom du fichier"
    read nom_fichier  
    echo "Saisir la date de création (ex: YYMMDDHHMM)"
    read date_creation
    echo "Saisir la date de modification (ex: YYMMDDHHMM)"
    read date_modification
    if touch -t "$date_creation" "$nom_fichier" && touch -mt "$date_modification" "$nom_fichier"; then
        echo "Les timestamps sont modifiés"
    else
        echo "Erreur : Impossible de modifier les timestamps"
    fi
}

# Fonction pour créer des liens symboliques
lien_symbolique() {
    echo "Saisir le chemin du répertoire ou fichier cible"
    read cible
    echo "Saisir le nom du lien symbolique à créer"
    read nom_lien
    if ln -s "$cible" "$nom_lien"; then
        echo "Le lien symbolique $nom_lien vers $cible est créé"
    else
        echo "Erreur : Impossible de créer le lien symbolique"
    fi
}

                   
# Menu principal

#!/bin/bash

while true; do
clear
echo "
                                                                                                                                                              
                                                                                  ,&@@@@@@@@@@@@@@&*,                                                                                                   
                    ,(%%&&@@@&&%#/.                         .&@@@@.             *@@@@(,,,......*#*,%@@@@(                                                                                               
              .(@@@@@@@%%#((#%%@@@@@@@#.                   .@@@@@(,.          .@@@#,,..          /@@@@(@@(,                                                                                   /,.       
           .%@@@@@#,,,...         ,#@@@@@%.               .@@@@@@*,.         #@@%,,..           #@@@@,,@@(,.                                                                                 (@@@@%,.   
         .&@@@@&,,..                 .@@@@@%.             &@@@@@&,,        .@@@/,..            /@@@@,,(@@*,.                                                                                *@@@@&,,.   
        (@@@@@*,..                     #@@@@@,           %@&%@@@#,.       ,@@&,,.             ,@@@@/,*@@(,.                                                                                 @@@@%,,.    
       %@@@@%,,.                        (@@@@@*.        /@&*@@@@(,.      ,@@%,..              &@@@#,.%@%,,.                                                                                &@@@@,,.     
      *@@@@@,,.                          %@@@@#,       ,@@/(@@@@*,.     ,@@%,,.              *@@@@*,&@&,,.                                                                                /@@@&,,.      
      %@@@@/,.                           .@@@@@*,      &@(,#@@@@*.     ,@@%,..   .(@@@@@(    @@@@#,%@%,,.    #@@@@@%         (@@@@@/      #&&&% .%@@@@*  .%@@@@%.        *&@@@@%.        .@@@@*,.       
     .@@@@@*,.                            %@@@@#,.    (@&,,&@@@@,.     @@&,,.  *@@@@%(@@@@, *@@@@*@@(,..  ,@@@@%(&@@&,     #@@@##@@@@/   .@@@@%@@@@@@@@(@@&@@@@@&,.   .&@@@&(&@@@*.      %@@@*,.        
      %@@@@*,.                 ,@(/,.     (@@@@%,.   ,@@*,,@@@@%,.    &@@,,.  &@@@#,,,@@@&,,%@@@%@@*,..  #@@@(,,.(@@@,,   #@@#,,.,@@@&,. (@@@@@(,,&@@@@@(,,/@@@@(,.  *@@@&*,.#@@@*..    ,@@@#,.         
      /@@@@%,.                 %@@@@#,    *@@@@&,,   %@(,.*@@@@#,.   /@@*,,  %@@@(,,/@@@%,,,@@@@@#,,.   #@@@#,...@@@%,,,@@@@@*.. .@@@@*..@@@@@/,.*@@@@@/,..%@@@&,.. /@@@&,,,&@@@*,.     &@@&,..         
       %@@@@#,                %@@@@%,..   *@@@@@,,  /@&,,.,@@@@(,.  *@@(,.  #@@@&,#@@@&,,..*@@@&,,..   *@@@%,,. %@@@*,.@@@@@%,.  /@@@@*.(@@@@/,. %@@@@/,. #@@@@*,. .@@@@//@@@@/,..     /@@@*,,          
        /@@@@@*             /@@@@@(,..    *@@@@@*, .@@*,. (@@@@/,.  &@%,,. .@@@@@@&/,,... ,@@@@%,.    .@@@@(,.     .,,%@@@@@@*.  %@@@#,/@@@@%,..,@@@@%,,./@@@@/,. .@@@@@@@#*,,..  &@*. &@@(,.           
          *@@@@@&(.     .#@@@@@@(,,.      *@@@@@*, (@#,,. (@@@@/,. /@@*,.  .@@@@(,..     *@@@@@#,.   ,@@@@@(,.      .@@@@@/#@@#.%@@@@#@@@@@@*,. #@@@@*,. @@@@#,,. @@@@@@,..     .&@*,.  **,,.           
             ,%@@@@@@@@@@@@@#*,,..        *@@@@@,,.@@*,.  #@@@@/,.,@@(,.   .@@@@@*.    .&@#%@@@%,.  #@(%@@@@*.    .%@&(@@@#,./@@@@@@&(*@@@@%,. .@@@@#,, (@@@@/,.,@&#@@@@/.     #@&,,.,(#/               
                 ...,,,,,,,...            *@@@@@,,@@(,.   %@@@@/,,%@%,,.    *@@@@@@#%@@@@*,/@@@@%/#@@/,*@@@@@@%#@@@@*,,@@@@%/#@@@@&,,.#@@@@*,, &@@@@*,. %@@@@%(@@(,,@@@@@@%#@@@@(,,*@@@@@&,.            
                                          *@@@@@,*@&,,.   %@@@@(,*@@*,.      .&@@@@@@@&*,.. (@@@@@@#,,.  #@@@@@@@%*,..  %@@@@@@@%*,...@@@@%,. *@@@@%,.   %@@@@@#,,.. (@@@@@@@@(,,..*@@@@@/,.            
                                          *@@@@@,%@(,.    %@@@@%,@@(,.           .,,,,...      ,,,,..       .,,,,...       ,,,,,..      .....    .....      .,,..       .,,,,,..      .,,..             
                                          .@@@@@/@&,..    #@@@@&(@&,,.                                                                                                                                  
                                           &@@@@@@*,.     (@@@@@&@/,.                                                                                                                                   
                                           *@@@@@%,,.     ,@@@@@@@,..                                                                                                                                   
                                            %@@@@*,.      .@@@@@@*,.                                                                                                                                    
                                               .,,.          .,**,.                                                                                                                                     
                                                                                                                                                                                                        
"                                                                                                                                                                                                        

figlet -f slant -c "IN CODEM3AYA "  | lolcat
echo "/*---------------------------------------------*/"
figlet -f digital  "MENU PRINCIPLE" | lolcat
    echo "/*---------------------------------------------*/"
    echo "1. Gestion des fichiers"
    echo "2. Gestion des répertoires"
    echo "3. Quitter"
    echo "/*---------------------------------------------*/"
    read -p $'\e[31msaisir votre choix : \e[0m' choix_menu_principal
    case $choix_menu_principal in
        1) # Menu gestion de fichiers
            while true; do
                clear 
          echo "_________________________________________________________________"
          echo "_________________________________________________________________"  
                figlet -f digital  "GESTION FICHIER" | lolcat                
          echo "_________________________________________________________________"
          echo -e "/* Votre position \e[1;34m$(pwd)\e[0m  */" 
            echo "___________________________________________________________________________________________________________________________________________________________________________"
          echo "le contenu de ce repertoir" 
          echo "--------------------------"      
                ls --color=auto
          echo "___________________________________________________________________________________________________________________________________________________________________________"          
                echo "Menu gestion de fichiers"
                echo "------------------------"
                echo "1 Création de fichier"
                echo "2 Suppression de fichier"
                echo "3 Renommage de fichier"
                echo "4 Copie de fichier"
                echo "5 Déplacement de fichier"
                echo "6 Recherche de fichier"
                echo "7 Gestion des autorisations"
                echo "8 Modification des timestamps"
                echo "9 Création de lien symbolique"
                echo "10 Retour au menu principal"
                echo "------------------------"
          echo "_________________________________________________________________"
          echo "_________________________________________________________________"    
                read -p $'\e[31msaisir votre choix : \e[0m'  choix_gestion_fichiers
                case $choix_gestion_fichiers in
                    1) creer_f ;;
                    2) supprimer_f ;;
                    3) renommer_f ;; 
                    4) copier_f ;;
                    5) deplacer_f ;; 
                    6) rechercher_f ;; 
                    7) gestion_autorisation ;;
                    8) modifier_timestamps ;;
                    9) lien_symbolique ;;
                    10) break ;;
                    *) echo "Choix invalide" ;;
                esac
                sleep 2
            done
            ;;
        2) # Menu gestion de répertoires
            while true; do
                clear 
          echo "_________________________________________________________________"
          echo "_________________________________________________________________"  
                figlet -f digital  "GESTION REPERTOIRE" | lolcat                
          echo "_________________________________________________________________"
          echo -e "/* Votre position \e[1;34m$(pwd)\e[0m  */"
           echo "___________________________________________________________________________________________________________________________________________________________________________"
          echo "le contenu de ce repertoir" 
          echo "--------------------------"      
                ls --color=auto
          echo "___________________________________________________________________________________________________________________________________________________________________________" 
                echo "Menu gestion de répertoires"
                echo "---------------------------"
                echo "1 Navigation dans les répertoires"
                echo "2 Création de répertoire"
                echo "3 Suppression de répertoire"
                echo "4 Renommage de répertoire"
                echo "5 Gestion des autorisations"
                echo "6 Retour au menu principal"
                echo "---------------------------"
          echo "_________________________________________________________________"
          echo "_________________________________________________________________"             
                read -p $'\e[31msaisir votre choix :  \e[0m'  choix_gestion_repertoires
                case $choix_gestion_repertoires in
                    1) naviguer ;;
                    2) creer_R ;;
                    3) supprimer_R ;;
                    4) renommer_R ;;
                    5) gestion_autorisation ;; 
                    6) break ;;
                    *) echo "Choix invalide" ;;
                esac
                sleep 2
            done     
            ;;
        3) exit ;;
        *) echo "Choix invalide" ;;
    esac
done



