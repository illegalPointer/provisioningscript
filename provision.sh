#!/bin/sh

YELLOW='\033[0;33m'
GRAY='\033[0;37m'
GREEN='\033[1;32m'
RED='\033[1;31m'

#pwd=$(pwd)
pendingtasks="Pending Tasks:"

# General
echo "${YELLOW}General${GRAY}"
tools="~/myTools"
mkdir $tools

    # Utilities 
    echo "\t${YELLOW}Utilities${GRAY}"
    utils="${tools}/utils"
    mkdir $utils

        # Update Projects
        echo "\t\t${YELLOW}update projects${GRAY}"
        cd $utils 
        git clone -q https://github.com/illegalPointer/updateprojects
        cp "${utils}/updateprojects/updateprojectsrecursive.sh" "${tools}/updateprojectsrecursive.sh"

        # Provisionsh
        echo "\t\t${YELLOW}Provisioning script${GRAY}"
        cd $utils
        git clone -q https://github.com/illegalPointer/provisioningscript

	# Bash Template
	echo "\t\t${YELLOW}Bash template${GRAY}"
        cd $utils
        git clone -q https://github.com/illegalPointer/bashtemplate

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
    pendingtasks="${pendingtasks}\n\t- Recommended: Change keystore password in ${signandalign}/${certname}\n\t\tkeytool -storepasswd -keystore testcert"
    cd $android

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
    
            # Finger user enum
            echo "${YELLOW}\t\t\tFinger-user-enum${GRAY}"
            cd $finger
            wget -q http://pentestmonkey.net/tools/finger-user-enum/finger-user-enum-1.0.tar.gz
            tar -xzf finger-user-enum-1.0.tar.gz
            rm finger-user-enum-1.0.tar.gz

        #Unix-Privesc
        echo "${YELLOW}\t\tUnix Privesc Check${GRAY}"
        cd $unix
        wget -q http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz
        tar -xzf unix-privesc-check-1.4.tar.gz
        rm unix-privesc-check-1.4.tar.gz

        # Bash
        echo "${YELLOW}\t\tBash Shell${GRAY}"
        cd $unix
        bash="${unix}/bash"
        bashversion="bash-4.3.30"
        mkdir $bash
        cd $bash
        wget -q https://ftp.gnu.org/gnu/bash/${bashversion}.tar.gz
    
            # Bash 32
            bash32="${bash}/bash32"
            mkdir $bash32
            cd $bash
            tar -xzf "${bashversion}.tar.gz" -C ${bash32} --strip-components 1 --no-same-owner
            cd $bash32
            # Bash 32: configure32
            ./configure --build=i686-pc-linux-gnu --enable-silent-rules "CC=gcc -m32" "CXX=g++ -m32" "LDFLAGS=-m32"
            make
    
            # Bash 64
            bash64="${bash}/bash64"
            mkdir $bash64
            cd $bash
            tar -xzf "${bashversion}.tar.gz" -C ${bash64} --strip-components 1 --no-same-owner
            cd $bash64
            # Bash 64: configure64
            ./configure --build=x86_64-pc-linux-gnu --enable-silent-rules "CC=gcc -m64" "CXX=g++ -m64" "LDFLAGS=-m64"
            make
        
        cd $bash
        rm "${bashversion}.tar.gz" 

    # Udp Proto scanner
    cd $infra
    echo "${YELLOW}\tUdp-proto-scanner${GRAY}"
    wget -q https://labs.portcullis.co.uk/download/udp-proto-scanner-1.1.tar.gz
    tar -xzf udp-proto-scanner-1.1.tar.gz --no-same-owner
    rm udp-proto-scanner-1.1.tar.gz

# Web
echo "${YELLOW}Web${GRAY}"
web="${tools}/web"
mkdir $web

    # Hoppy
    echo "\t${YELLOW}Hoppy Web Scanner${GRAY}"
    cd $web
    wget -q https://labs.portcullis.co.uk/download/hoppy-1.8.1.tar.bz2
    bzip2 -d -q hoppy-1.8.1.tar.bz2
    tar -xf hoppy-1.8.1.tar --no-same-owner
    rm hoppy-1.8.1.tar

    # Nikto
    echo "\t${YELLOW}Nikto Web Scanner${GRAY}"
    cd $web
    git clone -q https://github.com/sullo/nikto

    # Web Basic
    echo "\t${YELLOW}webBasic.sh${GRAY}"
    cd $web
    git clone -q https://github.com/illegalPointer/webBasic.sh
    
    # Crypto
    echo "\t${YELLOW}Crypo${GRAY}"
    crypto="${web}/crypto"
    mkdir ${crypto}
   
        # Test Poodle TSL        
        echo "\t\t${YELLOW}Test POODLE TLS${GRAY}"
        cd ${crypto}
        git clone -q https://github.com/exploresecurity/test_poodle_tls

        # Test SSL
        echo "\t\t${YELLOW}Test SSL ${GRAY}"
        cd ${crypto}
        git clone -q https://github.com/drwetter/testssl.sh

        # SSL Cipher Suite Enum
	echo "\t\t${YELLOW}SSL Cipher Suite Enum${GRAY}"
        cd ${crypto}
        wget -q https://labs.portcullis.co.uk/download/ssl-cipher-suite-enum-v1.0.2.tar.gz
        tar -xzf ssl-cipher-suite-enum-v1.0.2.tar.gz --no-same-owner
        rm ssl-cipher-suite-enum-v1.0.2.tar.gz

    # Fuzzing
    echo "\t${YELLOW}Fuzzing${GRAY}"
    fuzzing="${web}/fuzzing"
    mkdir $fuzzing

        # Dirb
        echo "\t\t${YELLOW}Dirb${GRAY}"
        cd $fuzzing
        wget -q https://sourceforge.net/projects/dirb/files/dirb/2.22/dirb222.tar.gz/download        
        tar -xzf download --nosameowner
        pendingtasks="${pendingtasks}\n\t- Compile Dirb, located in ${fuzzing}"

        # Wfuzz
        echo "\t\t${YELLOW}wFuzz${GRAY}"
        cd $fuzzing
        git clone -q https://github.com/xmendez/wfuzz

        # wFuzz Parser
        echo "\t\t${YELLOW}wFuzz Parser${GRAY}"
        cd $fuzzing
        git clone -q https://github.com/illegalPointer/wFuzzParser
    
# Fuzzing
echo "${YELLOW}FuzzLists${GRAY}"
flists="${tools}/fuzzingLists"
mkdir $flists
    
    # FuzzDB
    echo "\t${YELLOW}FuzzDB${GRAY}"
    cd $flists
    git clone -q https://github.com/fuzzdb-project/fuzzdb

    # SecLists
    echo "\t${YELLOW}Sec Lists${GRAY}"
    cd $flists
    git clone -q https://github.com/danielmiessler/SecLists


pendingtasks="${pendingtasks}\n\t- Add private repos, if needed"
echo "${GREEN}Finished!${GRAY}"
echo "${YELLOW}${pendingtasks}${GRAY}"
