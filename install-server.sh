#! /bin/bash

cat << EOF

 / \-------------------------------,
 \_,|                              |
    |    Minecraft-Server-Script   |
    |  ,-----------------------------
    \_/____________________________/
                        by Spleezer

EOF

echo "Welche Distribution benutzt du?"
echo "[1] Debian/Ubuntu"
echo "[2] Arch/Manjaro"
echo ""
echo -n "--> "
read distro_ans

echo ""
echo "Mit welcher Version soll dein Server laufen?"
echo "WICHTIG: Nur die Hauptversion angeben!"
echo "BEISPIEL: 1.17.2 --> 17"
echo ""
echo -n "--> "
read vers_ans

echo ""
echo "Mit welcher Subversion soll dein Server laufen?"
echo "WICHTIG: Nur die Subversion angeben!"
echo "BEISPIEL: 1.13.1 --> 1"
echo ""
echo -n "--> "
read subvers_ans

echo ""
echo "Welchen Server möchtest du nutzen?"
echo "[1] Vanilla (Normaler Server, kommt direkt von Mojang. Kein Pluginsupport.)"
echo "[2] Paper (Custom Server, läuft stabiler in neueren Versionen. + Plugins)"
echo "[3] Spigot (Custom Server, für ältere Versionen geeignet. + Plugins)"
echo ""
echo -n "--> "
read serv_ans

#hier wird die passende Java version installiert

if [ $distro_ans == 1 ];
then
    sudo apt install screen -y
    sudo ufw allow 25565
    if [ $vers_ans == 11 ] || [ $vers_ans -lt 11 ];
    then
        sudo apt install openjdk-8-jre-headless -y
    elif [ $vers_ans == 12 ] || [ $vers_ans -gt 12 && $vers_ans -lt 15 ] || [ $vers_ans == 15 ];
    then   
        sudo apt install openjdk-11-jre-headless -y
    elif [ $vers_ans == 16 ];
    then    
        sudo apt install openjdk-16-jre-headless -y
    elif [ $vers_ans -gt 16 ];
    then   
        sudo apt install openjdk-17-jre-headless -y
    else
        echo "FEHLER: Version nicht unterstützt. Wende dich bitte an den Entwickler."
    fi
elif [ $distro_ans == 2 ];
then
    sudo pacman -S screen --noconfirm
    sudo ufw allow 25565
    if [ $vers_ans == 11 ] || [ $vers_ans -lt 11 ];
    then
        sudo pacman -S jre8-openjdk-headless --noconfirm
    elif [ $vers_ans == 12 ] || [ $vers_ans -gt 12 && $vers_ans -lt 15 ] || [ $vers_ans == 15 ];
    then   
        sudo pacman -S jre11-openjdk-headless --noconfirm
    elif [ $vers_ans == 16 ];
    then    
        sudo pacman -S jre16-openjdk-headless --noconfirm
    elif [ $vers_ans -gt 16 ];
    then   
        sudo pacman -S jre17-openjdk-headless --noconfirm
    else
        echo "FEHLER: Version nicht unterstützt. Wende dich bitte an den Entwickler."
    fi
else
    echo "FEHLER: Distribution nicht unterstützt."
fi

mkdir ./server
cd ./server
echo "eula=true" >> eula.txt

#Hier wird versucht die passende serverjar zu holen

#Die Serverjars.com API Wird hier nürtlich sein, verbesserungspotential aber keine ahnung wie das geht! hihiheha

if [ $serv_ans == 1 ];
then
    wget -O server.jar https://serverjars.com/api/fetchjar/vanilla/vanilla/1.$vers_ans.$subvers_ans
elif [ $serv_ans == 2 ];
then
    wget -O server.jar https://serverjars.com/api/fetchJar/servers/paper/1.$vers_ans.$subvers_ans
elif [ $serv_ans == 3 ];
then
    wget -O server.jar https://serverjars.com/api/fetchJar/servers/spigot/1.$vers_ans.$subvers_ans
else
    echo "FEHLER: Kann keine passende Serverjar finden."
fi

echo "screen -S Server java -Xmx1G -jar server.jar nogui" >> start.sh
sudo chmod +x start.sh
./start.sh

echo ""
echo "Um den Server zu starten muss du die start.sh Datei ausführen!"
echo "Danke, dass du dieses Skript genutzt hast!"
