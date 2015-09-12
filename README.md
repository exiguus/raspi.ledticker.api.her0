#raspi.ledticker.api.her0
set of bash scripts that use the her0.be plaintext api  
for an lunartec led-dotmatrix 70x5 with he4d/ledticker  
connected to a raspberry pi  

#SETUP
Software requirements: he4d/ledticker, curl, cron  
Hardware requirements raspberry pi, led-dotmatrix 70x5 and sitecom USB to Serial  

    git clone https://github.com/he4d/ledticker.git
    cd ledticker
    make
    cp ledticker /usr/local/bin
    chmox +x /usr/local/bin/ledticker

    git clone https://github.com/exiguus/raspi.ledticker.api.her0.git
    mv /raspi.ledticker.api.her0/cron /etc/cron.d/her0-ledticker
    mkdir /usr/local/sbin/ledticker
    mv /raspi.ledticker.api.her0/*.sh /usr/local/sbin/ledticker
    chmod +x /usr/local/sbin/ledticker/*sh

    /etc/init.d/cron restart

#API
##Build your own api
* prints the latest items aboth the given item-id
* one item per line
* last line first item-id and last item-id

##Example
request  
    api.php?action=realtime&type=plain&item=$ITEMID  

response (plain/text)  
    18:27:53 kevin Joins  
    18:28:29 sasche Quits  
    18:28:55 tobias Parts  
    18:29:31 Simon Quits  
    9077 9081  
