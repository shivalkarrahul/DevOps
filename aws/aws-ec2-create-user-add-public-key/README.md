### Features

- Create user on the specied linux server

Create user on the specied linux server.
-------------

**Script Name:** provide-access.sh
**Parameters to the Script:** 5
**Usage:** ./provide-access.sh -U login-user-name -K path-to-login-pem-key -I login-ip  -u user-to-be-created -k  "public-key-to-be-added-in-double-quotes"
***Where,*** 
```
        -K .pem key of the server on which a new user has be created
        -U UserName of the server on which a new user has be created
        -I IP of the server on which a new user has be created
        -u user to be created on the internal server
        -k public key string to be added shared by the user
```
**Note:**
`Pass Public Key in double quotes`

**e.g.**
`./provide-access.sh -U ubuntu -K /Users/rahul/Documents/Rahul/access/rahuls.pem -I 192.168.134.100  -u rahul -k  "ssh-rsa Z1rbx6/F/ZntfkvKzX6e82ZXETBSMkFXZ2oYOOLb9QtTu4IO+W560+afjp1xLOYqWNyX+fI8N6WHKeEsZycq0iyHX5herNWxorLU3gGnwGSABCb+62yP3eaESMMV+9dJjFC9X4IyLHMR91OeDsxeLL41ABANofMROQ8yDjNcYVUxjKWyzNzuJxgnN5KngwkUOWHGbCFmHUsz1WVuWA+rhhk1CPZFywUdsDeGR/Dxd+oNKGvaKGIQuDqK1vY5GiLg0N+OvanTPbLper3/Z5A5d62fRF6+mensZGsKW543 key-name"`
