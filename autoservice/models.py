from django.db import models

class Clients(models.Model):
    first_name = models.CharField(max_length=100, null=True)
    last_name = models.CharField(max_length=100)
    phone = models.CharField(max_length=13)
    city = models.CharField(max_length=100)

    def __str__(self):
        return self.last_name
