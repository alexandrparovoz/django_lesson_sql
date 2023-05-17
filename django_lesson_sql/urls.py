
from django.contrib import admin
from django.urls import path, include


from django_lesson_sql import *

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('autoservice.urls'))
]
