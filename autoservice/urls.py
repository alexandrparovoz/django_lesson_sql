from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='home'),
    path('task_1/', views.task_1, name='task_1'),
    path('task_2/', views.task_2, name='task_2'),
    path('task_3/', views.task_3, name='task_3'),
    path('task_4/', views.task_4, name='task_4'),
    path('orders/', views.Orders, name='Orders'),
]