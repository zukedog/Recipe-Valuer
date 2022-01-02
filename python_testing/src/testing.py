import mysql.connector
import asciitable
import sys
from os import environ

class color:
   PURPLE = '\033[95m'
   CYAN = '\033[96m'
   DARKCYAN = '\033[36m'
   BLUE = '\033[94m'
   GREEN = '\033[92m'
   YELLOW = '\033[93m'
   RED = '\033[91m'
   BOLD = '\033[1m'
   UNDERLINE = '\033[4m'
   END = '\033[0m'

class tui:
    def menu(self, loop, *args):
        #args should be lists with 2 elements [name, function]
        looping = True
        while looping:
            looping = loop
            for i,(x,y,*z) in enumerate(args):
                print(f"{i+1}) {x}")
            print("b) back")
            i = input(f"1-{len(args)}: ")
            if i == "b":
                return
            elif (not i.isdigit()) or int(i) not in range(1, len(args)+1):
                print(f"Must be a number between 1 & {len(args)}")
                looping = True
            else:
                selected = args[int(i)-1]
                selected[1](*selected[2:])

    def table(self, title, headers, data):
        print(f"{color.BOLD}{title}{color.END}")
        asciitable.write(data, sys.stdout, names=headers, Writer=asciitable.FixedWidthTwoLine, bookend=False, delimiter=" | ")



interface = tui()

class Database:
    def __init__(self, host, user, password):
        self.db = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database="TestDB"
        )
print("Getting Environment Variables")
DATABASE_HOST = environ.get("DATABASE_HOST")
DATABASE_USER = environ.get("DATABASE_USER")
DATABASE_PASSWORD = environ.get("DATABASE_PASSWORD")
DATABASE_NAME = environ.get("DATABASE_NAME")
print('CONNECTING TO DATABASE')
db = mysql.connector.connect(
    host=DATABASE_HOST,
    user=DATABASE_USER,
    password=DATABASE_PASSWORD,
    database=DATABASE_NAME
)
print("CONNECTED")
cursor = db.cursor()

def get_suppliers():
    cursor.execute("SELECT id, name FROM Supplier;")
    return cursor.fetchall()

def list_suppliers():
    interface.table("Suppliers", ["id", "name"], get_suppliers())
    #for id, name in get_suppliers():
        #print(f'{id}) {name}')

def menu_ingredients():
    print("Imgredients:")

def menu_suppliers():
    print()
    list_suppliers()


interface.menu(True, ("Databases", print), ("Ingredients",print), ("Suppliers",menu_suppliers), ("Recipes",print))
