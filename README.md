# msg2desktop
a little helperrole for ansible to send short messages to users there are graphical logged in with ansible.

## Installation
- download the code with : `git clone https://github.com/borwinius/msg2desktop.git`
- copy the code in your ansible roles-directory
- make 3 Environmentvariables in ansible like this:
```
"msg_title": "'my Maintenance Message'",
"msg_msg": "'Please read the newest Message on our Homepage<br><a href=https://myportal>https://myportal</a>'",
"msg_duration": "5000"
```
be patient with the hicommas and commas.  

## test it with ansible  
include it in your own rolefile `role/MYROLE/tasks/main.yaml`  
```
- include_role:
     name: helper/msg2desktop
  when:
     - msg_title is defined
     - msg_msg is defined
     - msg_duration is defined
```
an Examplemessage:  
  
![examplemessage](example.png)  
  
manual test with:  
`./msg2desktop.sh -t 'my test' -m 'my message' -d 5000`

- checked only with KDE and GNOME
- this module will send the message to all loggedin users of a machine.
