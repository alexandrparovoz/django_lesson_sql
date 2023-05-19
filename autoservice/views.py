from django.shortcuts import render
from .models import *


def index(request):
    return render(request, 'autoservice/index.html')

def task_1(request):
    obj = Clients.objects.all()
    return render(request, 'autoservice/task_1.html', {{'obj': obj}})

def task_2(request):
    return render(request, 'autoservice/task_2.html')

def task_3(request):
    return render(request, 'autoservice/task_3.html')

def task_4(request):
    return render(request, 'autoservice/task_4.html')


# def sql (req, returnid = False):
#     import sqlite3 as sqlite
#     connection = sqlite.connect('db.sqlite3') # Название БД рядом с файликом manage.py
#     cursor = connection.cursor()
#     cursor.execute (str (req))
#     connection.commit()
#     if returnid == False:
#         rows = cursor.fetchall ()
#     else:
#         rows = cursor.lastrowid
#     cursor.close()
#     connection.close()
#     return rows