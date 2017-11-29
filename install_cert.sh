
! [[ -f "InstallCert.class" ]] && javac InstallCert.java

java InstallCert $1:$2

keytool -export -noprompt -alias $1-1 \
        -keystore jssecacerts \
        -storepass changeit \
        -file $1.cer
# 
# keytool -list -v \
#         -keystore jssecacerts \
#         -storepass changeit \
#         -alias $1 > $1.cer


PATH_TO_CACERTS=$JAVA_HOME/jre/lib/security/cacerts

[[ -f "$3" ]] && PATH_TO_CACERTS=$3

echo [[ "$3" -ge 1 ]];
echo $PATH_TO_CACERTS;


CERT_LIST=$(keytool -list -v -keystore $PATH_TO_CACERTS -storepass changeit)

if [[ $CERT_LIST  =~ .*$1.*  ]]; then
  keytool -delete -alias $1 -keystore $PATH_TO_CACERTS -storepass changeit
fi

keytool -importcert -alias $1 \
        -keystore $PATH_TO_CACERTS \
        -storepass changeit \
        -file $1.cer \
        -noprompt
