openssl s_client -connect gateway.sandbox.push.apple.com:2195 -cert PushChatCert.pem -key PushChatKey.pem




openssl x509 -in aps_development.cer -inform der -out PushChatCert.p12


cat PushChatCert.p12 PushKey.p12 > ck.p12


curl -X GET -H "Accept:application/json" http://localhost:8080/PushChatGrails/activeUserControllerRest



curl -H "Content-Type: application/json" -X POST -d '{"cmd":"JOIN","deviceToken":"123","ipAddress":"ipAddress","nickName":"kaod","secretCode":"Munich","userId":"1","username":"myUsername"}' http://localhost:8080/PushChatGrails/activeUserControllerRest/commands