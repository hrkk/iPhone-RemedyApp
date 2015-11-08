cd /Users/kasper/Projects/iPhone-RemedyApp/cert

openssl x509 -in aps_development.cer -inform der -out RemedyAppCert.pem



openssl pkcs12 -nocerts -out RemedyAppKey.pem -in RemedyAppKey.p12



cat RemedyAppCert.pem RemedyAppKey.pem > ck.pem



openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert RemedyAppCert.pem -key RemedyAppKey.pem

/// 

aps_development.cer <= download from Apple
mykey.p12 <= RemedyAppKey.p12




// for det virker med @Grab(group='com.notnoop.apns', module='apns', version='1.0.0.Beta6')
// server
openssl pkcs12 -export -inkey RemedyAppKey.pem -in RemedyAppCert.pem -out iphone_dev.p12


grep -lr "ApnsPushNotificationServiceImpl" *

mysqldump -u root -p loppemarkeder > /home/kasper/loppemarkederbck_20151108.sql