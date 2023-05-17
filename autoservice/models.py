from django.db import models

class Clients(models.Model):
    first_name = models.CharField(max_length=100, null=True)
    last_name = models.CharField(max_length=100)
    phone = models.CharField(max_length=13)
    city = models.CharField(max_length=100)

    def __str__(self):
        return self.last_name


class Auto(models.Model):
    car_model = models.CharField(max_length=100)
    model_year = models.CharField(max_length=4, null=True)
    client = models.ForeignKey(Clients, on_delete=models.PROTECT)

    def __str__(self):
        return self.car_model


class TypeService(models.Model):
    service = models.TextField(max_length=255)
    price = models.IntegerField(default=0)

    def __str__(self):
        return self.service


class Order(models.Model):
    auto_model = models.ForeignKey(Auto, on_delete=models.PROTECT)
    type_service = models.ForeignKey(TypeService, on_delete=models.PROTECT)
    date = models.DateTimeField(auto_now_add=True)




