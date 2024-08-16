from django.db import models
from common import enum


class Sponsor(models.Model):
    name = models.CharField()

class Bill(models.Model):
    """ A bill represents a bill or resolution introduced in the United States
    Congress.
    """
    title = models.CharField(max_length=200)
    sponsor = models.ForeignKey(Sponsor, on_delete=models.CASCADE)
    days_since_last_action = models.IntegerField()
    last_action = models.CharField(max_length=200)
