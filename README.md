# README
* START  
1. git clone  
1. bundle install  
1. mysql.server start  
1. rails db:create  
1. rails db:migrate  
1. rails db:seed  
1. rails s  

-Error when trying to install with mysql2 gem  
brew uninstall --force mysql && brew install mysql  
then  
sudo gem install mysql2  
or  
brew install openssl  
then  
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/  
