#!/bin/sh

YELLOW='\033[0;33m'
GRAY='\033[0;37m'
GREEN='\033[1;32m'
RED='\033[1;31m'

homeDir=$(echo ~)
pendingtasks="Pending Tasks:"

# General
echo "${YELLOW}General${GRAY}"
tools="${homeDir}/myTools2"
mkdir $tools

    # Utilities 
    echo "\t${YELLOW}Utilities${GRAY}"
    utils="${tools}/utils"
    mkdir $utils

        # Update Projects
        echo "\t\t${YELLOW}Update projects${GRAY}"
        cd $utils 
        git clone -q https://github.com/illegalPointer/updateprojects
        echo "\t\t\t${GREEN}Copying the script to ${tools}${GRAY}"
        cp "${utils}/updateprojects/updateprojectsrecursive.sh" "${tools}/updateprojectsrecursive.sh"

        # Provisionsh
        echo "\t\t${YELLOW}Provisioning script${GRAY}"
        cd $utils
        git clone -q https://github.com/illegalPointer/provisioningscript

	# Bash Template
	echo "\t\t${YELLOW}Bash template${GRAY}"
        cd $utils
        git clone -q https://github.com/illegalPointer/bashtemplate

# Mobile
echo "${YELLOW}Mobile${GRAY}"
mobile="${tools}/mobile"
mkdir $mobile

    # iOS
    echo "\t${YELLOW}iOS${GRAY}"
    ios="${mobile}/iOS"
    mkdir $ios

        # plutil.pl
        echo "\t\t${YELLOW}plutil.pl${gray}"
        cd $ios
        mkdir "${ios}/plutil"
        cd "${ios}/plutil"
        wget -q -U 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0' --no-check-certificate http://scw.us/iPhone/plutil/plutil.pl

        # FileDP
        echo "\t\t${YELLOW}FileDP${GRAY}"
        cd $ios
        mkdir "${ios}/fileDP"
        cd "${ios}/fileDP"
        wget -q -U 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0' --no-check-certificate http://www.securitylearn.net/wp-content/uploads/tools/iOS/FileDP.zip
        unzip FileDP.zip 1>/dev/null
        rm FileDP.zip

    # Android
    echo "\t${YELLOW}Android${GRAY}"
    android="${mobile}/android"
    mkdir $android

        # ApkTool
        echo "\t\t${YELLOW}apktool${GRAY}"
        apktool="$android/apktool"
        mkdir $apktool
        cd $apktool
        echo "http://ibotpeaches.github.io/Apktool/install/" >> HOW_TO_INSTALL
        pendingtasks="$pendingtasks\n\t- Install apktool ($apktool)"
        cd $android

        # Signandalign
        echo "\t\t${YELLOW}signandalign${GRAY}"
        signandalign="$android/signandalign"
        mkdir $signandalign
        cd $signandalign
        password="change_me"
        certname="testcert"
        certalias="testalias"
        scriptname="signandalign.sh"
        echo "#!/bin/sh\njarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $certname \$1 $certalias\nzipalign -f -v 4 \$1 \$1.temp\nmv \$1.temp \$1" >> $scriptname
        keytool -genkey -v -keystore $certname -keypass $password -storepass $password -dname "CN=Test_User, OU=Test_OU, O=Test_Org, L=Test_Locality, ST=Test_State, C=ES" -alias $certalias -keyalg RSA -keysize 2048 -validity 20000 1>/dev/null
        echo "$password" >> "${certname}_password.txt"
        pendingtasks="${pendingtasks}\n\t- Recommended: Change keystore password in ${signandalign}/${certname}\n\t\tkeytool -storepasswd -keystore testcert"
        cd $android

        #MobSF
        echo "\t\t${YELLOW}MobSF${GRAY}"
        cd ${android}
        git clone -q https://github.com/ajinabraham/Mobile-Security-Framework-MobSF
        cd "${android}/Mobile-Security-Framework-MobSF"
        echo "\t\t\t${GREEN}Installing Mob-SF requisites${GRAY}"
        pip install -r requirements.txt --user 1>/dev/null
    
        # Jadx
        echo "\t\t${YELLOW}Jadx${GRAY}"
        cd ${android}
        git clone -q https://github.com/skylot/jadx
    
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
        echo "${GREEN}\t\t\tDownloading ${bashversion}${GRAY}"
        wget -q https://ftp.gnu.org/gnu/bash/${bashversion}.tar.gz
    
            # Bash 32
            echo "${GREEN}\t\t\tCompiling ${bashversion} 32 bits${GRAY}"
            bash32="${bash}/bash32"
            mkdir $bash32
            cd $bash
            tar -xzf "${bashversion}.tar.gz" -C ${bash32} --strip-components 1 --no-same-owner
            cd $bash32
            # Bash 32: configure32
            ./configure --build=i686-pc-linux-gnu --quiet "CC=gcc -m32" "CXX=g++ -m32" "LDFLAGS=-m32" 1>/dev/null
            make --debug=n --silent 1>/dev/null
    
            # Bash 64
            echo "${GREEN}\t\t\tCompiling ${bashversion} 64 bits${GRAY}"
            bash64="${bash}/bash64"
            mkdir $bash64
            cd $bash
            tar -xzf "${bashversion}.tar.gz" -C ${bash64} --strip-components 1 --no-same-owner
            cd $bash64
            # Bash 64: configure64
            ./configure --build=x86_64-pc-linux-gnu --quiet "CC=gcc -m64" "CXX=g++ -m64" "LDFLAGS=-m64" 1>/dev/null
            make --debug=n --silent 1>/dev/null
        
        cd $bash
        rm "${bashversion}.tar.gz" 

    # Udp Proto scanner
    cd $infra
    echo "${YELLOW}\tUdp-proto-scanner${GRAY}"
    wget -q https://labs.portcullis.co.uk/download/udp-proto-scanner-1.1.tar.gz
    tar -xzf udp-proto-scanner-1.1.tar.gz --no-same-owner
    rm udp-proto-scanner-1.1.tar.gz

    # Nmap Launcher
    cd ${infra}
    echo "${YELLOW}\tNmapLauncher${GRAY}"
    git clone -q https://github.com/illegalPointer/nmapLauncher

# Web
echo "${YELLOW}Web${GRAY}"
web="${tools}/web"
mkdir $web

    # Hoppy
    echo "\t${YELLOW}Hoppy Web Scanner${GRAY}"
    cd $web
    wget -q --no-check-certificate https://labs.portcullis.co.uk/download/hoppy-1.8.1.tar.bz2
    bzip2 -d -q hoppy-1.8.1.tar.bz2
    tar -xf hoppy-1.8.1.tar --no-same-owner
    rm hoppy-1.8.1.tar
    hoppyWebBasic="$(pwd)/hoppy-1.8.1/hoppy"

    # Nikto
    echo "\t${YELLOW}Nikto Web Scanner${GRAY}"
    cd $web
    wget -q wget https://cirt.net/nikto/nikto-2.1.5.tar.gz
    tar -xzf nikto-2.1.5.tar.gz
    rm nikto-2.1.5.tar.gz
    niktoWebBasic="$(pwd)/nikto-2.1.5/nikto.pl"

    # Web Basic
    echo "\t${YELLOW}webBasic.sh${GRAY}"
    cd $web
    git clone -q https://github.com/illegalPointer/webBasic.sh
    webBasicLocation="$(pwd)/webBasic.sh/webBasic.sh"
    
    # Crypto
    echo "\t${YELLOW}Crypto${GRAY}"
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
        testSSLBasic="${crypto}/testssl.sh/testssl.sh"

        # SSL Cipher Suite Enum
	echo "\t\t${YELLOW}SSL Cipher Suite Enum${GRAY}"
        cd ${crypto}
        wget --no-check-certificate -q https://labs.portcullis.co.uk/download/ssl-cipher-suite-enum-v1.0.2.tar.gz
        tar -xzf ssl-cipher-suite-enum-v1.0.2.tar.gz --no-same-owner
        rm ssl-cipher-suite-enum-v1.0.2.tar.gz
        cipherEnumSSLBasic="${crypto}/ssl-cipher-suite-enum-v1.0.2/ssl-cipher-suite-enum.pl"

        # SSLBasic.ch
        echo "\t\t${YELLOW}sslBasic.sh${GRAY}"
        cd ${crypto}
        git clone -q https://github.com/illegalPointer/sslBasic.sh
        sslBasicLocation="${crypto}/sslBasic.sh"

    # Fuzzing
    echo "\t${YELLOW}Fuzzing${GRAY}"
    fuzzing="${web}/fuzzing"
    mkdir $fuzzing

        # Dirb
        echo "\t\t${YELLOW}Dirb${GRAY}"
        cd $fuzzing
        wget -q --no-check-certificate https://sourceforge.net/projects/dirb/files/dirb/2.22/dirb222.tar.gz/download        
        tar -xzf download --no-same-owner
        rm download
        chmod -R 755 dirb222/
        cd dirb222/
        echo "\t\t\t${GREEN}Building dirb${GRAY}"
        dirbWebBasic="$(pwd)/dirb"
        ./configure --quiet 1>/dev/null
        make --quiet 1>/dev/null

        # Wfuzz
        echo "\t\t${YELLOW}wFuzz${GRAY}"
        cd $fuzzing
        git clone -q https://github.com/xmendez/wfuzz

        # wFuzz Parser
        echo "\t\t${YELLOW}wFuzz Parser${GRAY}"
        cd $fuzzing
        git clone -q https://github.com/illegalPointer/wFuzzParser


   # XXE
   echo "\t${YELLOW}XXE${GRAY}"
   xxe="${web}/xxe"
   mkdir $xxe

       # OXL
       echo "\t\t${YELLOW}oxml_xxe${GRAY}"
       cd $xxe
       git clone -q https://github.com/BuffaloWill/oxml_xxe
    
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
    dirListWebBasic="$(pwd)/SecLists/Discovery/Web_Content/common.txt"

# Reversing
echo "${YELLOW}Reversing${GRAY}"
reversing="${tools}/reversing"
mkdir $reversing

    # Radare2
    echo "${YELLOW}\tRadare2${Gray}"
    cd $reversing
    git clone -q https://github.com/radare/radare2
    cd radare2
    echo "${GREEN}\t\tInstalling radare${GRAY}"
    sys/install.sh 1>/dev/null

pendingtasks="${pendingtasks}\n\t- Consider Setting webBasic.sh located at ${webBasicLocation} with the following Vars\n\t\tHOPPY=\"${hoppyWebBasic}\"\n\t\tNIKTO=\"${niktoWebBasic}\"\n\t\tDIRB=\"${dirbWebBasic}\"\n\t\tDIRLIST=\"${dirListWebBasic}\""
pendingtasks="${pendingtasks}\n\t- Consider Setting sslBasic.sh located at ${sslBasicLocation} with the following Vars\n\t\tTESTSSL=\"${testSSLBasic}\"\n\t\tSSLENUM=\"${cipherEnumSSLBasic}\""
pendingtasks="${pendingtasks}\n\t- Add private repos, if needed"
pendingtasks="${pendingtasks}\n\t- Execute sudo apt-get install sqlitebrowser"
echo "${GREEN}Finished!${GRAY}"
echo "${YELLOW}${pendingtasks}${GRAY}"
