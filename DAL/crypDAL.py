from cryptography.fernet import  Fernet
import os

_key= r"../appkey.key"

def load_key():
        return open(_key, "rb").read()


key = load_key()
fer=Fernet(key)


 
def write_key():
    key = Fernet.generate_key()
    with open(_key, "wb") as key_file:
        key_file.write(key)
 


def add():
   # name = input('login: ')
   # pwd = input('Senha: ')
    name='dbmon'
    pwd = 'monitor'.encode().decode()
    k = load_key()

    with open('../passwords.txt','a') as f:
        f.write( name + "|" + fer.encrypt(pwd.encode()).decode()  + "\n" ) #    fer.encrypt(pwd.encode()).decode()

 
 
 
def getDBpwd():
    with open('../passwords.txt','r') as f:
        for line in f.readlines():
            data = line.rstrip()
            user,passw = data.split("|")
    return fer.decrypt(passw.encode()).decode()
 
