#!/bin/sh

YELLOW='\033[0;33m'
GRAY='\033[0;37m'
GREEN='\033[1;32m'
RED='\033[1;31m'

pwd=$(pwd)
pendingtasks="Pending Tasks:"

# General
echo "${YELLOW}General${GRAY}"
tools="${pwd}/tools"
mkdir $tools

    # Utilities 
    echo "\t${YELLOW}Utilities${GRAY}"
    utils="${tools}/utils"
    mkdir $utils

        # Update Projects
        echo "\t${YELLOW}update projects${GRAY}"
        cd $utils 
        git clone https://github.com/illegalPointer/updateprojects
        cp "${utils}/updateprojects/updateprojectsrecursive.sh" "${tools}/updateprojectsrecursive.sh"

# Android
echo "${YELLOW}Android${GRAY}"
android="${tools}/android"
mkdir $android
    # ApkTool
    echo "\t${YELLOW}apktool${GRAY}"
    apktool="$android/apktool"
    mkdir $apktool
    cd $apktool
    echo "http://ibotpeaches.github.io/Apktool/install/" >> HOW_TO_INSTALL
    pendingtasks="$pendingtasks\n\t- Install apktool ($apktool)"
    cd $android

    # Signandalign
    echo "\t${YELLOW}signandalign${GRAY}"
    signandalign="$android/signandalign"
    mkdir $signandalign
    cd $signandalign
    password="change_me"
    certname="testcert"
    certalias="testalias"
    scriptname="signandalign.sh"
    echo "#!/bin/sh\njarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $certname \$1 $certalias\nzipalign -f -v 4 \$1 \$1.temp\nmv \$1.temp \$1" >> $scriptname
    keytool -genkey -v -keystore $certname -keypass $password -storepass $password -dname "CN=Test_User, OU=Test_OU, O=Test_Org, L=Test_Locality, ST=Test_State, C=ES" -alias $certalias -keyalg RSA -keysize 2048 -validity 20000
    echo "$password" >> "${certname}_password.txt"
    pendingtasks="${pendingtasks}\n\t- Recommended: Change keystore password in ${signandalign}/${certname}"
    cd $android

cd $tools

# Infra
echo "${YELLOW}Infrastructure${GRAY}"
infra="${tools}/infra"
mkdir $infra
cd $infra

    # Unix
    echo "${YELLOW}\tUnix${GRAY}"
    unix="${infra}/unix"
    mkdir $unix
    
        # Finger
        echo "${YELLOW}\t\tFinger${GRAY}"
        finger="${unix}/finger"
        mkdir $finger
        cd $finger
    
            # Finger user enum
            echo "${YELLOW}\t\t\tFinger-user-enum${GRAY}"
            wget http://pentestmonkey.net/tools/finger-user-enum/finger-user-enum-1.0.tar.gz
            tar -xzvf finger-user-enum-1.0.tar.gz
            rm finger-user-enum-1.0.tar.gz
    
        cd $unix

        #Unix-Privesc
        echo "${YELLOW}\t\tUnix Privesc Check${GRAY}"
        wget http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz
        tar -xzvf unix-privesc-check-1.4.tar.gz
        rm unix-privesc-check-1.4.tar.gz

        # Bash
        echo "${YELLOW}\t\tBash Shell${GRAY}"
        bash="${unix}/bash"
        bashversion="bash-4.3.30"
        mkdir $bash
        cd $bash
        wget https://ftp.gnu.org/gnu/bash/${bashversion}.tar.gz
    
            # Bash 32
            bash32="${bash}/bash32"
            mkdir $bash32
            cd $bash
            tar -xzvf "${bashversion}.tar.gz" -C ${bash32} --strip-components 1
            cd $bash32
            # Bash 32: configure32
            ./configure --build=i686-pc-linux-gnu "CC=gcc -m32" "CXX=g++ -m32" "LDFLAGS=-m32"
            make
    
            # Bash 64
            bash64="${bash}/bash64"
            mkdir $bash64
            cd $bash
            tar -xzvf "${bashversion}.tar.gz" -C ${bash64} --strip-components 1
            cd $bash64
            # Bash 64: configure64
            ./configure --build=x86_64-pc-linux-gnu "CC=gcc -m64" "CXX=g++ -m64" "LDFLAGS=-m64"
            make
        
        cd $bash
        rm "${bashversion}.tar.gz" 
        cd $unix
    cd $infra

    # Udp Proto scanner
    cd $infra
    echo "${YELLOW}\tUdp-proto-scanner${GRAY}"
    wget https://labs.portcullis.co.uk/download/udp-proto-scanner-1.1.tar.gz
    tar -xzvf udp-proto-scanner-1.1.tar.gz
    rm udp-proto-scanner-1.1.tar.gz

# Web
echo "${YELLOW}Web${GRAY}"
web="${tools}/web"
mkdir $web

    # Crypto
    echo "\t${YELLOW}Crypo${GRAY}"
    crypto="${web}/crypto"
    mkdir ${crypto}
    cd ${crypto}
    
        # Test Poodle TSL
        echo "\t\t${YELLOW}Test POODLE TLS${GRAY}"
        git clone https://github.com/exploresecurity/test_poodle_tls

        # Test SSL
        echo "\t\t${YELLOW}Test SSL ${GRAY}"
        git clone https://github.com/drwetter/testssl.sh

    
# FuzzDB
echo "${YELLOW}FuzzDB${GRAY}"
cd $tools
git clone https://github.com/fuzzdb-project/fuzzdb

pendingtasks="${pendingtasks}\n\t- Add private repos, if needed"
echo "${GREEN}Finished!${GRAY}"
echo "${YELLOW}${pendingtasks}${GRAY}"
