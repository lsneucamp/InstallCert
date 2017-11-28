
rm InstallCert*.class
rm jssecacerts
rm *.cer

javac InstallCert.java

java InstallCert $1:$2

keytool -exportcert -alias $1-1 \
        -keystore jssecacerts \
        -storepass changeit \
        -file $1.cer


sudo keytool -importcert -alias $1 \
        -keystore $JAVA_HOME/jre/lib/security/cacerts \
        -storepass changeit \
        -file $1.cer
